import 'package:final_proj/main.dart';
import 'package:final_proj/userRecipes/stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "package:final_proj/userRecipes/stream_builder.dart";
import "mapping/map.dart";

class StarterPage extends StatelessWidget {
  const StarterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      resizeToAvoidBottomInset: false,
      tabBar: CupertinoTabBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.auto_stories),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map_outlined),
        )
      ]),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return const CupertinoPageScaffold(
                  resizeToAvoidBottomInset: false, child: MyHomePage());
            });
          case 1:
            return CupertinoTabView(builder: (context) {
              return const CupertinoPageScaffold(
                  resizeToAvoidBottomInset: false,
                  child: StreamBuilderWidget()); //StreamBuilder is ryans widget
            });
          case 2:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                  resizeToAvoidBottomInset: false,
                  child: Map()); //StreamBuilder is ryans widget
            });
          default:
            return CupertinoTabView(builder: (context) {
              return const CupertinoPageScaffold(
                  resizeToAvoidBottomInset: false, child: MyHomePage());
            });
        }
      },
    );
  }
}
