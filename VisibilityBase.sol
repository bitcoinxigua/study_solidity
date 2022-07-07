// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

contract VisibilityBase {
    uint private x = 0;
    uint internal y = 1;
    uint public z = 2;
    
    //合约内部调用可以通过this.,但是不建议这种写法，比较消耗gas
    function externalFunc() external pure returns(uint){
        return 3;
    }

    function example() external view returns(uint){
        return x + y + z + this.externalFunc();
    }

}

contract VisibilityChild is VisibilityBase {
    
    function example2() external view returns(uint) {
        return y + z + this.externalFunc();
    }

}

