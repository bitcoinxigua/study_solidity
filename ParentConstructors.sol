// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

contract S {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

contract T {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

//第一种方式,直接在定义合约的时候传参
contract U is S("s"),T("t") {
}

//第二种方式，在构造函数中传参
contract V is S,T {
    constructor(string memory _name,string memory _text) S(_name) T(_text) {}
}

//第三种方式，前两种方式的结合
contract W is S("s"),T {
    constructor(string memory _text) T(_text) {}
}
//构造函数的先后顺序以is后面的先后顺序为准