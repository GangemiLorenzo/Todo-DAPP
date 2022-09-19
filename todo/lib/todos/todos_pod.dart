import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/artifacts/TodoContract.dart';
import 'package:todo/session/session_pod.dart';
import 'package:todo/todos/models/todo.dart';
import 'package:todo/web3_service.dart';
import 'package:web3dart/credentials.dart';

final contractProvider = Provider<TodoContract>((ref) {
  return TodoContract(
    address: EthereumAddress.fromHex(dotenv.env['CONTRACT_ADDRESS']!),
    client: ref.watch(web3ServiceProvider).getEthClient(),
  );
});

final todosListProvider = FutureProvider.autoDispose<List<Todo>>((ref) async {
  final credentials = ref.watch(sessionProvider).credentials;
  final contract = ref.watch(contractProvider);

  final response = await contract.getTodos(credentials: credentials!);
  final todos = response.map((e) => Todo.fromContract(e)).toList();

  return todos;
});

final addTodoProvider = Provider<
    Function({
  required String text,
  required String color,
})>((ref) {
  final credentials = ref.watch(sessionProvider).credentials;
  final contract = ref.watch(contractProvider);

  return ({
    required String text,
    required String color,
  }) async {
    await contract.addTodo(
      text,
      color,
      credentials: credentials!,
    );
    ref.refresh(todosListProvider);
  };
});

final updateTodoProvider = Provider<Function(Todo)>((ref) {
  final credentials = ref.watch(sessionProvider).credentials;
  final contract = ref.watch(contractProvider);

  return (Todo todo) async {
    await contract.updateTodo(
      todo.id,
      !todo.isDone,
      credentials: credentials!,
    );
    ref.refresh(todosListProvider);
  };
});
