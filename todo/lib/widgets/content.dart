import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/todos/models/todo.dart';
import 'package:todo/todos/todos_pod.dart';
import 'package:todo/widgets/todo_widget.dart';

class Content extends ConsumerWidget {
  const Content({
    required this.todos,
    Key? key,
  }) : super(key: key);

  final List<Todo> todos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: todos
                .map(
                  (t) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TodoWidget(
                      color: colorFromHex(t.color.substring(2)),
                      id: t.id,
                      text: t.text,
                      checked: t.isDone,
                      key: Key('${t.id}'),
                      onTap: () => ref.watch(updateTodoProvider).call(t),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  Color colorFromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
