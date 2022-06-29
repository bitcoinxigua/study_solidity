// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

contract Error {

    uint public num = 110;
    
    function testRequire(uint i) external {
        num = 911;
        require(i <= 10 , "i can not >10");
        // code
    }

    function testRevert(uint i) external {
        num = 911;
        if(i > 10) {
            revert("i can not >10");
        }
    }

    uint public a = 123;

    function testAssert() external view {
        assert(a == 123);
    }

    function foo() external {
        a++;
    }

    error MyError(address caller ,uint i);

    function testMyError(uint i) external view {
        if(i > 10) {
            revert MyError(msg.sender,i);
        }
    }

}