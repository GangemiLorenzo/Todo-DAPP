import 'package:web3dart/web3dart.dart';

//This file was initially generated from we3dart

final _contractAbi = ContractAbi.fromJson(
    '[{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"recipient","type":"address"},{"indexed":false,"internalType":"uint256","name":"todoId","type":"uint256"}],"name":"AddTodo","type":"event"},{"inputs":[{"internalType":"string","name":"text","type":"string"},{"internalType":"string","name":"color","type":"string"}],"name":"addTodo","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"getTodos","outputs":[{"components":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"address","name":"owner","type":"address"},{"internalType":"string","name":"text","type":"string"},{"internalType":"bool","name":"isDone","type":"bool"},{"internalType":"string","name":"color","type":"string"}],"internalType":"struct TodoContract.Todo[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"},{"internalType":"uint256","name":"","type":"uint256"}],"name":"todos","outputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"address","name":"owner","type":"address"},{"internalType":"string","name":"text","type":"string"},{"internalType":"bool","name":"isDone","type":"bool"},{"internalType":"string","name":"color","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"id","type":"uint256"},{"internalType":"bool","name":"isDone","type":"bool"}],"name":"updateTodo","outputs":[],"stateMutability":"nonpayable","type":"function"}]',
    'TodoContract');

class TodoContract extends GeneratedContract {
  TodoContract(
      {required EthereumAddress address,
      required Web3Client client,
      int? chainId})
      : super(DeployedContract(_contractAbi, address), client, chainId);

  Future<String> addTodo(String text, String color,
      {required Credentials credentials, Transaction? transaction}) async {
    final function = self.abi.functions[0];
    assert(checkSignature(function, '1b7fb260'));
    final params = [text, color];
    return write(credentials, transaction, function, params);
  }

  Future<List<dynamic>> getTodos(
      {required Credentials credentials, BlockNum? atBlock}) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, 'c33926cb'));
    final params = [];
    final sender = await credentials.extractAddress();
    final response = await read(sender, function, params, atBlock);
    return (response[0] as List<dynamic>).cast<dynamic>();
  }

  Future<String> updateTodo(BigInt id, bool isDone,
      {required Credentials credentials, Transaction? transaction}) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, '1f22e5f9'));
    final params = [id, isDone];
    return write(credentials, transaction, function, params);
  }
}
