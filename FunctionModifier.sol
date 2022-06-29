// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

contract FunctionModifier {

    uint public count;

    bool public flag = true;

    address owner;

    constructor() {//部署合约的人为合约的拥有者，有最高的权限
        owner = msg.sender;
    }

    function add() external ifPass {
        count++;
    }

    function inc() external ifPass {
        count--;
    }

    modifier ifPass() {
        require(flag,"not allow pass");
        _;
    }

    modifier ifOwner() {
        require(msg.sender == owner,"user is not owner");
        _;
    }

    function setFlag(bool _flag) external ifOwner {
        flag = _flag;
    }

    modifier cap(uint x) {
        require(x>0,"x should > 0");
        _;
    }

    function addBy(uint x) external ifPass cap(x){
        count += x;
    }

    function foo() external sandwich returns(uint) {
        count += 1;
        return count;
    }

    modifier sandwich() {
        count += 10;
        _;
        count *= 2;
    }

}