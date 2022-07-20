// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.10;

contract GasGolf {

    uint public total;

    //gas  50886
    function sum(uint[] memory nums) external {
        for(uint i = 0;i<nums.length;i+=1) {
            bool isEven = nums[i] % 2 == 0;
            bool isLessThan99 = nums[i] < 99;
            if(isEven && isLessThan99) {
                total += nums[i];
            }
        }
    }

    //gas  30947
    function summ(uint[] calldata nums) external {
        uint _total = total;
        uint len = nums.length;

        for(uint i = 0;i<len;++i) {
            uint num = nums[i];
            if(num % 2 ==0 && num<99) {
                _total += num;
            }
        }
        total = _total;
    }
    
}