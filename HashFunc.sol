// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.6;

contract HashFunc {

    function hash(string memory text,uint num,address addr) external pure returns(bytes32) {
        return keccak256(abi.encodePacked(text,num,addr));
    }

    function encode(string memory text0,string memory text1) external pure returns(bytes memory) {
        return abi.encode(text0,text1);
    }

    //这个方法有漏洞，因为没有补零导致不同的参数可能会产生同样的结果
    function encodePacked(string memory text0,string memory text1) external pure returns(bytes memory) {
        return abi.encodePacked(text0,text1);
    }

    //解决方案：1、使用encode打包 2、在两个字符串中间加一个数字
    function collision(string memory text0,uint num,string memory text1) external pure returns(bytes32) {
        return keccak256(abi.encodePacked(text0,num, text1));
    }
    
}