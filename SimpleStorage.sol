// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

contract SimpleStorage {

    string public text;

    function set(string calldata _text) external {
        text = _text;
    }

    function get() external view returns(string memory) {
        return text;
    }
    //同样的参数memory消耗的gas，51731，calldata消耗的gas，51177
}