import 'package:flut_impl/routing/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoApp.router(
        routerConfig: goRouter,
        debugShowCheckedModeBanner: false,
        theme: CupertinoThemeData(),
        builder: (context, child) {
          return Material(child: child);
        },
      );
    } else {
      return MaterialApp.router(
        routerConfig: goRouter,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
          ),
        ),
      );
    }
  }
}
