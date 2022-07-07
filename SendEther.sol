// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

contract SendEther {
    constructor() payable {}

    function sendViaTransfer(address payable _to) external {
        _to.transfer(123);
    }

    function sendViaSend(address payable _to) external {
        bool success = _to.send(123);
        require(success,"send failed");
    }

    function sendViaCall(address payable _to) external {
        (bool success,) = _to.call{value:123}("");
        require(success,"call failed");
    }
}

contract EthReceiver {

    event Log(uint amount,uint gas);

    receive() external payable {
        emit Log(msg.value , gasleft());
    }
}