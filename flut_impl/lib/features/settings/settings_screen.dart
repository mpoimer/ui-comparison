import 'package:flut_impl/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Widget _buildiOS(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Settings'),
      ),
      child: SafeArea(
        child: Center(
          child: CupertinoButton.filled(
            child: const Text('Edit Profile'),
            onPressed: () => context.push('/settings/edit-profile'),
          ),
        ),
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Text('Settings'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      buildiOS: _buildiOS,
      buildAndroid: _buildAndroid,
    );
  }
}
