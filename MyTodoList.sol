// SPDX-License-Identifier: UNLICENSED
pragma solidity >0.8.7;

contract MyTodoList {

    struct Todo {
        string text;
        bool completed;
    }

    Todo[] public todos;

    function create(string calldata _text) external {
        todos.push(Todo({
            text : _text,
            completed : false
        }));
    }

    function updateText(uint _index,string calldata _text) external {
        todos[_index].text = _text;//适合字段少

        // Todo storage todo = todos[_index];
        // todo.text = _text;
    }

    function updateFlag(uint _index) external {
        todos[_index].completed = !todos[_index].completed;
    }

    function get(uint _index) external view returns(string memory,bool) {
        Todo storage todo = todos[_index];//节约gas
        //Todo memory todo = todos[_index];
        return (todo.text,todo.completed);
    }

}