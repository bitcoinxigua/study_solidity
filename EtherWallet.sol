// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

contract EtherWallet {
    //状态变量加上immutable，gas费28586，这种方式gas费最低
    address payable public immutable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable{}

    function withdraw(uint _amount) external {
        require(msg.sender == owner,"caller not owner");
        //这种写法使用内存中的msg.sender，gas费,30718
        // payable(msg.sender).transfer(_amount);
        //这种写法使用状态变量的owner，gas费，30852
        owner.transfer(_amount);
    }

    function balance() external view returns(uint){
        return address(this).balance;
    }
    
}