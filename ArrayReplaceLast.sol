// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

contract ArrayReplaceLast {

    uint[] public arr;

    function remove(uint _index) public {
        arr[_index] = arr[arr.length - 1];
        arr.pop();
    }

    function test() external returns(uint[] memory) {
        arr = [1,2,3,4,5];
        remove(2);
        return arr;
    }
}