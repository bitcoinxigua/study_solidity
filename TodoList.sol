// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

contract TodoList {

    struct Todo {
        string text;
        bool completed;
    }

    Todo[] public todos;

    function create(string calldata _text) external {
        todos.push(Todo({
            text : _text,
            completed :false
        }));
    }

    function updateText(uint _index,string calldata _text) external {
        //37315
        // todos[_index].text = _text;//第一种更新方式，适用于更新字段较少，如果更新字段太多的话会消耗比较多的gas

        //第二种更新方式，当字段较多的时候比第一种节省gas
        Todo storage todo = todos[_index];
        todo.text = _text;
        //37329
    }

    function get(uint _index) external view returns(string memory,bool) {
        //29397
        // Todo storage todo = todos[_index];
        Todo memory todo = todos[_index];
        //29480
        //装到存储中比内存中节约gas，为什么呢？
        //因为storage的Todo是直接从状态变量中读取的，如果使用memory需要经历一次从状态变量到局部变量的转换
        return (todo.text,todo.completed);
    }

    function toggleCompleted(uint _index) external {
        todos[_index].completed = !todos[_index].completed;
    }
}