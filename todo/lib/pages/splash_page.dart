import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Image(
                      image:
                          AssetImage("assets/images/impact_transparent.png")),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  "Todo - DAPP",
                  style: TextStyle(
                    fontSize: 32.0,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
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
    );
  }
}
