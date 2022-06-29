// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

contract TestContract1 {

    address public owner = msg.sender;

    function setOwner(address _owner) public {
        require(msg.sender == owner,"not owner");
        owner = _owner;
    }

}

contract TestContract2 {
    address public owner = msg.sender;
    uint public value = msg.value;
    uint public x;
    uint public y;

    constructor(uint _x,uint _y) payable {
        x = _x;
        y = _y;
    }

}

contract Proxy {

    event Deploy(address);//通过事件，向链外汇报合约部署的地址

    fallback() external payable{}//回退函数

    function deploy(bytes memory _code) external payable returns(address addr) {
        assembly {
            //内联汇编语法
           addr := create(callvalue(), add(_code , 0x20) , mload(_code))
        }
        require(addr != address(0),"deploy failed");//判断合约部署是否成功，合约地址为非0地址

        emit Deploy(addr);//触发事件
    }

    function execute(address _target, bytes memory _data) external payable {
        (bool success,) =_target.call{value:msg.value}(_data);
        require(success,"failed");
    } 
}

contract Helper {//帮助合约

    function getBytecode1() external pure returns(bytes memory) {//获取合约的字节码
        bytes memory bytecode =type(TestContract1).creationCode;
        return bytecode;
    }

    function getBytecode2(uint _x,uint _y) external pure returns(bytes memory) {//获取带参数合约的字节码
        bytes memory bytecode = type(TestContract2).creationCode;
        return abi.encodePacked(bytecode,abi.encode(_x,_y));
    }

    function getCalldata(address _owner) external pure returns(bytes memory) {//调用设置管理员方法
        return abi.encodeWithSignature("setOwner(address)",_owner);
    }

}

