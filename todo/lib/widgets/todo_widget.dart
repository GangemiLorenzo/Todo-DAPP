import 'package:flutter/material.dart';

class TodoWidget extends StatefulWidget {
  const TodoWidget({
    required this.color,
    required this.id,
    required this.text,
    required this.onTap,
    this.checked = false,
    Key? key,
  }) : super(key: key);

  final Color color;
  final BigInt id;
  final String text;
  final bool checked;
  final Function onTap;

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> with TickerProviderStateMixin {
  bool panDown = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (details) {
        setState(() {
          panDown = true;
        });
      },
      onPanCancel: () => {
        setState(() {
          panDown = false;
        })
      },
      onPanEnd: (details) => {
        setState(() {
          panDown = false;
        })
      },
      onTap: () => widget.onTap(),
      child: Stack(
        children: [
          Positioned.fill(
              child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 2.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
            ),
          )),
          Positioned.fill(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0, right: 2.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
            ),
          )),
          Positioned.fill(
              child: Padding(
            padding: const EdgeInsets.all(0.5),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(0.5),
            child: Container(
              decoration: widget.checked
                  ? BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          widget.color.withAlpha(50),
                          widget.color.withAlpha(25),
                        ],
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    )
                  : BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            widget.color.withAlpha(50),
                            widget.color.withAlpha(25),
                            Colors.blueGrey.withAlpha(25),
                            Colors.blueGrey.withAlpha(25),
                            Colors.black.withAlpha(10),
                          ],
                          stops: [
                            0.0,
                            0.15,
                            0.3,
                            0.4,
                            1
                          ]),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 24.0),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Positioned.fill(
                          child: Center(
                            child: Container(
                              height: 16,
                              width: 16,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4.0),
                                  ),
                                  border: Border.all(
                                    color: widget.color,
                                    width: 2.5,
                                  )),
                            ),
                          ),
                        ),
                        Positioned(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10.0, left: 6.0),
                                child: Icon(
                                  Icons.check,
                                  size: 28,
                                  color: !widget.checked
                                      ? Colors.transparent
                                      : null,
                                ))),
                      ],
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Positioned.fill(
                              child: AnimatedPadding(
                            padding: EdgeInsets.only(
                                right: widget.checked
                                    ? 0
                                    : MediaQuery.of(context).size.width),
                            duration: Duration(milliseconds: 400),
                            child: Container(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Theme.of(context).colorScheme.onBackground
                                  : Colors.black,
                            ),
                          )),
                          Text(
                            widget.text,
                            style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Theme.of(context).colorScheme.onBackground
                                    : null,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (panDown)
            Positioned.fill(
                child: Padding(
              padding: const EdgeInsets.all(0.5),
              child: Container(
                decoration: BoxDecoration(
                  color: widget.color.withAlpha(10),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
              ),
            )),
        ],
      ),
    );
  }
}
