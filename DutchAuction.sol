// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.10;

interface IERC721 {
    function transferFrom(
        address _from,
        address _to,
        uint _nftId
    ) external;
}

contract DutchAuction {
    //拍卖经历的时间周期
    uint private constant DURATION = 7 days;

    IERC721 public immutable nft;
    uint public immutable nftId;
    //卖家地址
    address payable public immutable seller;
    //起拍价
    uint public immutable startingPrice;
    //起拍时间
    uint public immutable startAt;
    //过期时间
    uint public immutable expiresAt;
    //每秒的折扣率
    uint public immutable discountRate;

    constructor(
        uint _startingPrice,
        uint _discountRate,
        address _nft,
        uint _nftId
    ) {
        seller = payable(msg.sender);
        startingPrice = _startingPrice;
        discountRate = _discountRate;
        startAt = block.timestamp;
        expiresAt = block.timestamp + DURATION;

        require(
            _startingPrice >= _discountRate * DURATION,
            "starting price < discount"
        );

        nft = IERC721(_nft);
        nftId = _nftId;
    }

    function getPrice() public view returns(uint) {
        uint timeElapsed = block.timestamp - startAt;
        uint discount = discountRate * timeElapsed;
        return startingPrice - discount;
    }

    function buy() external payable {
        require(block.timestamp < expiresAt,"auction expired");
        uint price = getPrice();
        require(msg.value >= price,"ETH < PRICE");
        nft.transferFrom(seller,msg.sender,nftId);

        uint refund = msg.value - price;
        if(refund > 0) {
            payable(msg.sender).transfer(refund);
        }
        selfdestruct(seller);
    }


}