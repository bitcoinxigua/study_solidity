// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

contract IterableMapping {

    mapping(address => uint) private balances;
    mapping(address => bool) private inserted;
    address[] private keys;

    function set(address _key,uint _val) external {
        balances[_key] = _val;

        if(!inserted[_key]) {
            inserted[_key] = true;
            keys.push(_key);
        }
    }

    function getSize() view external returns(uint){
        return keys.length;
    }

    function first() external view returns(uint) {
        return balances[keys[0]];
    }

    function last() external view returns(uint) {
        return balances[keys[keys.length - 1]];
    }

    function get(uint _i) external view returns(uint) {
        return balances[keys[_i]];
    }

}