import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/session/session_pod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  child: Image(
                      image: AssetImage("assets/images/doge-computer.png")),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 24.0,
              ),
              Text(
                "Hello!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32.0,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Text(
                "This is Todo-DAPP.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32.0,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Text(
                "Login and start your todo journey on the blockchain.",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Divider(),
              SizedBox(
                height: 24,
              ),
              TextButton(
                  onPressed: () =>
                      ref.read(sessionProvider.notifier).loginWithMetamask(),
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: SvgPicture.asset('assets/images/metamask.svg',
                            semanticsLabel: 'Metamask Logo'),
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Text(
                        "Continue with Metamask",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(
                        width: 40.0,
                      ),
                    ],
                  )),
              SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Cover credits: @WilliamTempest",
                    style: TextStyle(fontSize: 8.0),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
