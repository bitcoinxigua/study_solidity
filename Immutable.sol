// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

contract Immutable {

    //gas 45657
    //address public owner;

    //gas 43524
    address public immutable owner;

    constructor(){
        owner = msg.sender;
    }

    uint public x ;

    function foo() external {
        require(owner == msg.sender);
        x++;
    }

}