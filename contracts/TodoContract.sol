// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract TodoContract {
    event AddTodo(address recipient, uint256 todoId);

    struct Todo {
        uint256 id;
        address owner;
        string text;
        bool isDone;
        string color;
    }

    mapping(address => Todo[]) public todos;

    function addTodo(string memory text, string memory color) external {
        uint256 id = todos[msg.sender].length;
        todos[msg.sender].push(Todo(id, msg.sender, text, false, color));
        emit AddTodo(msg.sender, id);
    }

    function updateTodo(uint256 id, bool isDone) external {
        todos[msg.sender][id].isDone = isDone;
    }


    function getTodos() external view returns (Todo[] memory) {
        return todos[msg.sender];
    }
}
