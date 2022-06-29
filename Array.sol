// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

contract Array {

    uint[] public nums = [1,2,3];//动态数组

    uint[3] public fixedNums = [4,5,6];//定长数组

    function example() external {
        nums.push(4);//向数组的尾部推入数据，定长数组无
        uint x = nums[1];//通过索引访问数组中的元素
        nums[2] = 777;//通过索引修改数组元素
        delete nums[1];//通过delete删除数组元素，删除元素并不会修改数组的长度，而是把值改为元素的默认值
        nums.pop();//弹出数组中最后一个值，数组长度减一，定长数组无
        uint len = nums.length;//通过.length方法获取数组长度

        //在内存中创建数组
        uint[] memory a = new uint[](5);
    }

    function returnArray() external view returns(uint[] memory) {
        return nums;
    }
}