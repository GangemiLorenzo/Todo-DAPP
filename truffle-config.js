module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*"
    },
    loc_todo_todo: {
      network_id: "*",
      port: 7545,
      host: "127.0.0.1"
    }
  },
  contracts_build_directory: "./artifacts/",
  mocha: {},
  compilers: {
    solc: {
      version: "0.8.15"
    }
  }
};
