import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/main.dart';
import 'package:todo/session/session_pod.dart';
import 'package:todo/todos/todos_pod.dart';

class Header extends ConsumerWidget {
  const Header();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(
          height: 80.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: FutureBuilder(
                      future: ref
                          .watch(sessionProvider)
                          .credentials!
                          .extractAddress(),
                      builder: (ctx, snapshot) => snapshot.hasData
                          ? Text(
                              snapshot.data.toString(),
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                              ),
                              overflow: TextOverflow.ellipsis,
                            )
                          : Text(''),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Todo - DAPP",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Row(children: [
                    IconButton(
                      onPressed: () =>
                          ref.watch(sessionProvider.notifier).disconnect(),
                      icon: Icon(Icons.logout),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    IconButton(
                      onPressed: () {
                        showTodoDialog(context, (text, color) {
                          ref.watch(addTodoProvider).call(
                                text: text,
                                color: color,
                              );
                        });
                      },
                      icon: Icon(Icons.add),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    IconButton(
                      onPressed: () => {
                        MyApp.themeNotifier.value =
                            MyApp.themeNotifier.value == ThemeMode.light
                                ? ThemeMode.dark
                                : ThemeMode.light
                      },
                      icon: Icon(
                        MyApp.themeNotifier.value == ThemeMode.light
                            ? Icons.dark_mode
                            : Icons.light_mode,
                        size: 24.0,
                      ),
                    )
                  ])
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
      ],
    );
  }

  void showTodoDialog(BuildContext context, Function(String, String) onSubmit) {
    final textController = TextEditingController();
    Color color = Colors.redAccent;
    final myFocusNode = FocusNode();
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(32.0),
            title: Center(
              child: Text(
                "Add Todo",
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
              ),
            ),
            content: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        focusNode: myFocusNode,
                        controller: textController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Content',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  ColorPicker(
                    onColorChanged: (c) => {color = c},
                    pickersEnabled: {
                      ColorPickerType.both: false,
                      ColorPickerType.primary: false,
                      ColorPickerType.accent: true,
                      ColorPickerType.bw: false,
                      ColorPickerType.custom: false,
                      ColorPickerType.wheel: false
                    },
                    enableShadesSelection: false,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onSubmit.call(textController.text,
                          '0x${color.value.toRadixString(16).padLeft(6, '0')}');
                    },
                    child: Text("Confirm"),
                  ),
                ],
              ),
            ),
          );
        });
    myFocusNode.requestFocus();
  }
}
