// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.6;

contract Kill {

    constructor() payable{}

    function kill() external {
        selfdestruct(payable(msg.sender));
    }

    function num() external pure returns(uint) {
        return 123;
    }

}

contract Helper {
    function getBalance() external view returns(uint) {
        return address(this).balance;
    }

    function kill(Kill _kill) external {
        _kill.kill();
    }
}