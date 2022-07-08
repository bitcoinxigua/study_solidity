// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

interface ICounter {

    function count() external view returns(uint);

    function inc() external;

    function dec() external;
}

contract CallInterface {
    uint public count;

    function example(address _count) external {
        ICounter(_count).inc();
        ICounter(_count).inc();
        ICounter(_count).inc();
        ICounter(_count).dec();
        count = ICounter(_count).count();
    }
}