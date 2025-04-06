import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_impl_least_effort/routing/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerConfig: goRouter,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
          ),
        ),
        builder: (context, child) {
          return CupertinoTheme(
            data: const CupertinoThemeData(),
            child: Material(child: child),
          );
        });
  }
}
