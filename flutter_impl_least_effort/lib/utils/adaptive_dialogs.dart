import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogActionAdaptive extends StatelessWidget {
  const DialogActionAdaptive({
    super.key,
    required this.onPressed,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    required this.child,
  });

  final VoidCallback? onPressed;
  final bool isDefaultAction;
  final bool isDestructiveAction;
  final Widget child;

  @override
  Widget build(BuildContext context) => Platform.isIOS || Platform.isMacOS
      ? CupertinoDialogAction(
          onPressed: onPressed,
          isDefaultAction: isDefaultAction,
          isDestructiveAction: isDestructiveAction,
          child: child,
        )
      : TextButton(
          onPressed: onPressed,
          child: child,
        );
}
