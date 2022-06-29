// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

contract DataLocation {
    struct student {
        string name;
        uint age;
    }

    mapping(address => student) public students;

    function example() external {
        students[msg.sender] = student({name:"liu",age:18});
        student storage stu = students[msg.sender];
        stu.name = "zhou";
    }
}