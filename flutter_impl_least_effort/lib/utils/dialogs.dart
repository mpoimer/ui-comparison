import 'package:flutter/material.dart';
import 'package:flutter_impl_least_effort/utils/adaptive_dialogs.dart';

class Dialogs {
  static Future<bool?> showDeleteAccountDialog(BuildContext context) {
    return showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: Text('Delete Account'),
        content: Text('Are you sure you want to delete your account?'),
        actions: [
          DialogActionAdaptive(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          DialogActionAdaptive(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context, true),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
