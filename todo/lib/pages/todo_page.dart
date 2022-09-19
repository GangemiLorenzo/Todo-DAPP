import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/todos/todos_pod.dart';
import 'package:todo/widgets/widgets.dart';

class TodoPage extends ConsumerWidget {
  const TodoPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Header(),
        SizedBox(
          height: 16.0,
        ),
        ref.watch(todosListProvider).when(
              data: (todos) => Content(
                todos: todos,
              ),
              error: (_, __) => Expanded(
                child: Center(
                  child: Text('Error'),
                ),
              ),
              loading: () => Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
      ],
    );
  }
}
