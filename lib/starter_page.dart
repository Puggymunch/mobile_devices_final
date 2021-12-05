import 'package:final_proj/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class StarterPage extends StatelessWidget {
  const StarterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.auto_stories),
        )
      ]),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return const CupertinoPageScaffold(child: MyHomePage());
            });
          case 1:
            return CupertinoTabView(builder: (context) {
              return const CupertinoPageScaffold(child: MyHomePage());
            });
          default:
            return CupertinoTabView(builder: (context) {
              return const CupertinoPageScaffold(child: MyHomePage());
            });
        }
      },
    );
  }
}
