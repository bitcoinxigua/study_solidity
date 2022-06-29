// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

contract GlobalVariables {

    function globalVars() external view returns(address,uint,uint){
        address sender = msg.sender;
        uint time = block.timestamp;
        uint blockNum = block.number;
        return(sender,time,blockNum);
    }
}