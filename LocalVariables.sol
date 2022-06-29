// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

contract LocalVariables {
    uint public a;
    bool public b;
    address public myAddress;

    function foo() external returns(uint,bool){
        uint x = 123;
        bool f = false;
        x += 456;
        f = true;

        a += 123;
        b = true;
        myAddress = address(1);
        return (x,f);
    }
}