// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

contract Mapping {

    mapping(address => uint) public balances;

    mapping(address => mapping(address => bool)) public isFriend;//映射嵌套

    function examples() external returns(uint bal,uint bal2){
        balances[msg.sender] = 123;//赋值
        bal = balances[msg.sender];//获取值
        bal2  = balances[address(1)];//如果key不存在，返回默认值

        delete balances[msg.sender];//删除值并不是把key删除，而是把value置为默认值

        isFriend[msg.sender][address(this)] = true;//嵌套映射赋值

    }
}