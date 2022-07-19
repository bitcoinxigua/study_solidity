// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.10;

contract MultiDelegateCall {

    error DelegateCallFailed();
    
    function multiDelegateCall(bytes[] calldata data) external payable returns(bytes[] memory results) {
        results = new bytes[](data.length);

        for (uint i;i< data.length;i++) {
            (bool ok,bytes memory res)=address(this).delegatecall(data[i]);
            if(!ok) {
                revert DelegateCallFailed();
            }
            results[i] = res;
        }
    }
}

//多重委托调用，在多重调用的基础上显示真实的调用方
contract TestMultiDelegateCall is MultiDelegateCall {

    event Log(address caller,string func,uint i);

    function func1(uint x,uint y) external {
        emit Log(msg.sender,"func1",x+y);
    }

    function func2() external returns(uint) {
        emit Log(msg.sender,"func2",2);
        return 111;
    }

    mapping(address => uint) public balanceOf;

    //多重委托调用的漏洞，gas只扣了一次，值却加了多次
    function mint() external payable {
        balanceOf[msg.sender] += msg.value;
    }
}

contract Helper {
    function getFunc1Data(uint x,uint y) external pure returns (bytes memory) {
        return abi.encodeWithSelector(TestMultiDelegateCall.func1.selector,x,y);
    }

    function getFunc2Data() external pure returns (bytes memory) {
        return abi.encodeWithSelector(TestMultiDelegateCall.func2.selector);
    }

    function getMintData() external pure returns (bytes memory) {
        return abi.encodeWithSelector(TestMultiDelegateCall.mint.selector);
    }
}