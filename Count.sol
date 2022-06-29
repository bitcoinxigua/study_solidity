// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

contract Count {

    int public num;

    function add() external {
        num += 1;
    }

    function dec() external {
        num -= 1;
    }
}