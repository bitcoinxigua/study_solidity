// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.6;

library Math {
    function max(uint x,uint y) internal pure returns(uint) {
        return x >= y ? x : y;
    }
}

contract Test {

    function testMax(uint x, uint y) external pure returns(uint) {
        return Math.max(x , y);
    }
}

library ArrayLib {
    function find(uint[] storage arr,uint x) internal view returns(uint) {
        for(uint i = 0; i < arr.length; i++) {
            if(arr[i] == x) {
                return i;
            }
        }
        revert("not found");
    }
}

contract TestArray {
    //将这个库应用到所有的uint数组
    using ArrayLib for uint[];
    uint[] public arr = [3,2,1];

    function testFind(uint x) external view returns(uint) {
        //所有的uint数组可以通过方法名直接调用
        return arr.find(x);
    }
}