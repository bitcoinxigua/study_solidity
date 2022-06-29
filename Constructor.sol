// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

contract Constructor {

    uint public x;

    address public owner;

    constructor(uint _x) {
        x = _x;
        owner = msg.sender;
    } 
}