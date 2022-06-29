// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

contract FunctionOutPuts {

    function returnMany() public pure returns(uint ,bool) {
        return (1 ,true);
    }

    //隐式返回
    function assigned() public pure returns(uint x , bool b) {
        x = 1;
        b = true;
    }

    //接收返回值
    function getReturns() public pure returns(uint,bool) {
        (uint x,bool b) = assigned();
        return (x,b);
    }

    //如果只需要一个返回值，可以只接收一个返回值，这样比较节省gas
    function getOneReturns() public pure returns(bool) {
        (,bool b) = assigned();
        return b;
    }

}