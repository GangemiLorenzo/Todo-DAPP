import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:web3dart/web3dart.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo {
  factory Todo({
    required BigInt id,
    required String owner,
    required String text,
    required bool isDone,
    required String color,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  static Todo fromContract(List<dynamic> t) => Todo(
      id: (t[0] as BigInt),
      owner: (t[1] as EthereumAddress).hex,
      text: t[2],
      isDone: t[3],
      color: t[4]);
}

class AddTodoArgs {
  AddTodoArgs({
    required this.text,
    required this.color,
  });

  final String text;
  final String color;
}
