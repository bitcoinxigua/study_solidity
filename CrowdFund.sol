// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./ERC20.sol";

contract CrowdFund {
    event Launch(
        uint id,
        address indexed creator,
        uint goal,
        uint32 startAt,
        uint32 endAt
    );

    event Cancel(uint id);

    event Pledge(uint indexed id,address indexed caller,uint amount);

    event Unpledge(uint indexed id,address indexed caller,uint amount);

    event Claim(uint id);

    event Refund(uint indexed id,address indexed caller,uint amount);

    struct Campaign {
        //众筹创建者
        address creator;
        //众筹目标
        uint goal;
        uint32 startAt;
        uint32 endAt;
        uint pledged;
        //是否取款
        bool claimed;
    }

    IERC20 public immutable token;
    //筹款活动计数器，可以看当前有多少个筹款活动存在
    uint public count;
    mapping(uint => Campaign) public campaigns;
    mapping(uint => mapping(address => uint)) public pledgedAmount;

    constructor(address _token) {
        token = IERC20(_token);
    }

    function launch(uint _goal,uint32 _startAt,uint32 _endAt) external {
        require(_startAt >= block.timestamp,"");
        require(_endAt >= _startAt,"");
        require(_endAt <= block.timestamp +90 days,"");

        count += 1;
        campaigns[count] = Campaign({
            creator : msg.sender,
            goal : _goal,
            startAt : _startAt,
            endAt : _endAt,
            pledged : 0,
            claimed :false
        });
        emit Launch(count,msg.sender,_goal,_startAt,_endAt);
    }

    function cancel(uint _id) external {
        Campaign memory campaign =  campaigns[_id];
        require(msg.sender == campaign.creator,"");
        require(campaign.startAt > block.timestamp,"");
        delete campaigns[_id];
        emit Cancel(_id);
    }

    //参与众筹
    function pledge(uint _id,uint _amount) external {
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp >= campaign.startAt,"");
        require(block.timestamp <= campaign.endAt,"");
        campaign.pledged += _amount;
        pledgedAmount[_id][msg.sender] += _amount;
        token.transferFrom(msg.sender,address(this),_amount);
        
        emit Pledge(_id,msg.sender,_amount);
    }

    function unpledge(uint _id,uint _amount) external {
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp <= campaign.endAt,"");

        campaign.pledged -= _amount;
        pledgedAmount[_id][msg.sender] -= _amount;
        token.transfer(msg.sender,_amount);

        emit Unpledge(_id,msg.sender,_amount);
    }

    function claim(uint _id) external {
        Campaign storage campaign = campaigns[_id];
        require(msg.sender == campaign.creator,"");
        require(block.timestamp >= campaign.endAt,"");
        require(campaign.pledged >= campaign.goal,"");
        require(!campaign.claimed,"");

        campaign.claimed = true;
        token.transfer(msg.sender,campaign.pledged);

        emit Claim(_id);
    }

    function refund(uint _id) external {
        Campaign storage campaign = campaigns[_id];

        require(block.timestamp >= campaign.endAt,"");
        require(campaign.pledged < campaign.goal,"");

        uint bal = pledgedAmount[_id][msg.sender];
        pledgedAmount[_id][msg.sender] = 0;
        token.transfer(msg.sender,bal);

        emit Refund(_id,msg.sender,bal);
    }

}