// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

//   E
//  / \
// F   G
//  \ /
//   H
contract E {
    event Log(string message);

    function foo() public virtual {
        emit Log("E.foo");
    }

    function bar() public virtual {
        emit Log("E.bar");
    }
}

contract F is E {
    function foo() public virtual override {
        emit Log("F.foo");
        E.foo();//第一种方式，通过父级合约函数名调用
    }

    function bar() public virtual override {
        emit Log("F.bar");
        super.bar();//第二种方式，通过super关键字调用
    }
}

contract G is E {
    function foo() public virtual override {
        emit Log("G.foo");
        E.foo();//第一种方式，通过父级合约函数名调用
    }

    function bar() public virtual override {
        emit Log("G.bar");
        super.bar();//第二种方式，通过super关键字调用
    }
}

contract H is F, G {
    function foo() public override(F,G) {
        F.foo();//先调用F的函数，再调用E的函数
    }

    function bar() public override(F,G) {
        super.bar();//先会调用F和G的函数，再调用E的函数
    }
}
