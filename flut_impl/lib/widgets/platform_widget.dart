import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlatformWidget extends StatelessWidget {
  const PlatformWidget({
    super.key,
    required this.buildiOS,
    required this.buildAndroid,
  });

  final Widget Function(BuildContext context) buildiOS;
  final Widget Function(BuildContext context) buildAndroid;

  @override
  Widget build(BuildContext context) {
    return defaultTargetPlatform == TargetPlatform.iOS ? buildiOS(context) : buildAndroid(context);
  }
}
