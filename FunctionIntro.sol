// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

contract FunctionIntro {

    function add(uint x,uint y) external pure returns(uint) {
        return x + y;
    }

    function sub(int x,int y) external pure returns(int) {
        return x - y;
    }
}