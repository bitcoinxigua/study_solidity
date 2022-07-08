// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

contract Counter {
    uint public count;

    function inc() external {
        count++;
    }

    function dec() external {
        count -= 1;
    }
}