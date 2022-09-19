const TodoContract = artifacts.require("TodoContract");

contract("TodoContract", (accounts) => {

  it("WHEN calls addTodo once and getTodos THEN his todos are returned", async () => {
    const text = "Buy the milk";
    const contract = await TodoContract.deployed();
    await contract.addTodo(text, "0xFFFFFF");
    const result = await contract.getTodos();

    assert(result[0].text === text);
    assert(result[0].id === "0");
    assert(result[0].isDone === false);
    assert(result[0].owner === accounts[0]);
  });

  it("WHEN calls addTodo once again and getTodos THEN both his todos are returned", async () => {
    const text = "Buy some sugar";
    const contract = await TodoContract.deployed();
    await contract.addTodo(text, "0xFFFFFF");
    const result = await contract.getTodos();

    assert(result.length == 2);
    assert(result[1].text === text);
    assert(result[1].id === "1");
    assert(result[1].isDone === false);
    assert(result[1].owner === accounts[0]);
  });

  it("WHEN calls updateTodo on first Todo with positive value and getTodos THEN first todo is returned with positive value", async () => {
    const contract = await TodoContract.deployed();
    await contract.updateTodo(0, true);
    const result = await contract.getTodos();

    assert(result.length == 2);
    assert(result[0].isDone === true);
    assert(result[1].isDone === false);
  });

});


contract("TodoContract different owners", (accounts) => {

  it("WHEN first owner calls addTodo once and getTodos THEN only his todos are returned", async () => {
    const owner = accounts[0];

    const text = "Buy the milk";
    const contract = await TodoContract.deployed();
    await contract.addTodo(text, "0xFFFFFF", { from: owner });
    const result = await contract.getTodos({ from: owner });

    assert(result[0].text === text);
    assert(result[0].id === "0");
    assert(result[0].isDone === false);
    assert(result[0].owner === owner);
  });

  it("WHEN second owner calls addTodo once and getTodos THEN only his todos are returned", async () => {
    const owner = accounts[1];

    const text = "Buy the milk";
    const contract = await TodoContract.deployed();
    await contract.addTodo(text, "0xFFFFFF", { from: owner });
    const result = await contract.getTodos({ from: owner });


    assert(result[0].text === text);
    assert(result[0].id === "0");
    assert(result[0].isDone === false);
    assert(result[0].owner === owner);
  });

});


