// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.10;

interface IERC721 {
    function transferFrom(
        address _from,
        address _to,
        uint _nftId
    ) external;
}

contract EnglishAuction {
    event Start();
    event Bid(address indexed sender,uint amount);
    event Withdraw(address indexed bidder,uint amount);
    event End(address indexed highestBidder,uint highestBid);

    IERC721 public immutable nft;
    uint public immutable nftId;
    
    address payable public immutable seller;
    uint32 public endAt;
    bool public started;
    bool public ended;

    address public highestBidder;
    uint public highestBid;
    mapping(address => uint) public bids;

    constructor(
        address _nft,
        uint _nftId,
        uint _startingBid
    ) {
        nft = IERC721(_nft);
        nftId = _nftId;
        seller = payable(msg.sender);
        highestBid = _startingBid;
    }

    function start() external {
        require(msg.sender == seller,"");
        require(!started,"");

        started = true;
        endAt = uint32(block.timestamp + 60);
        nft.transferFrom(seller,address(this),nftId);

        emit Start();
    }

    function bid() external payable {
        require(started,"");
        require(block.timestamp < endAt,"");
        require(msg.value > highestBid,"");

        if(highestBidder != address(0)) {
            bids[highestBidder] += highestBid;
        }

        highestBid = msg.value;
        highestBidder = msg.sender;
        emit Bid(msg.sender,msg.value);
    }

    function withdraw() external {
        uint bal = bids[msg.sender];
        bids[msg.sender] = 0;
        payable(msg.sender).transfer(bal);
        emit Withdraw(msg.sender,bal);
    }

    function end() external {
        require(started,"");
        require(!ended,"");
        require(block.timestamp>endAt,"");

        ended = true;
        if(highestBidder != address(0)) {
            nft.transferFrom(address(this),highestBidder,nftId);
            seller.transfer(highestBid);
        } else {
            nft.transferFrom(address(this),seller,nftId);
        }
        emit End(highestBidder,highestBid);
    }


}