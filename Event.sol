// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

contract Event {

    event Log(string message,uint val);
    
    //事件中带角标的参数最多不能超过3个
    event IndexedLog(address indexed sender,uint val);
    //带角标是为了方便链外检索

    function example() external{
        emit Log("foo",1234);//触发事件
        emit IndexedLog(msg.sender,789);
    }

    event Message(address indexed _from,address indexed _to,string message);

    function sendMessage(address _to,string calldata message) external{
        emit Message(msg.sender,_to,message);
    }
}