import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static Future<bool?> showDeleteAccountDialog(BuildContext context) {
    return defaultTargetPlatform == TargetPlatform.iOS ? _showIOSDeleteAccountDialog(context) : _showAndroidDeleteAccountDialog(context);
  }

  static Future<bool?> _showIOSDeleteAccountDialog(BuildContext context) {
    return showCupertinoDialog<bool?>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Delete Account'),
        content: Text('Are you sure you want to delete your account?'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context, false),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: Text('Delete'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
  }

  static Future<bool?> _showAndroidDeleteAccountDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Account'),
        content: Text('Are you sure you want to delete your account?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
