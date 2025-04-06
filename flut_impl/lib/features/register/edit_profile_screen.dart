import 'dart:convert';

import 'package:flut_impl/user_model.dart';
import 'package:flut_impl/utils/date_formatter.dart';
import 'package:flut_impl/utils/dialogs.dart';
import 'package:flut_impl/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String _gender = 'other';
  bool _emailUpdates = true;
  DateTime _birthday = DateTime.now();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  Widget _buildiOS(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Settings'),
        leading: CupertinoButton(
          sizeStyle: CupertinoButtonSize.medium,
          onPressed: _togglePlatform,
          child: const Icon(CupertinoIcons.refresh),
        ),
        trailing: CupertinoButton(
          sizeStyle: CupertinoButtonSize.medium,
          onPressed: () {},
          child: const Text('Save'),
        ),
      ),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  CupertinoFormSection.insetGrouped(
                    header: Text(
                      'Personal Information'.toUpperCase(),
                    ),
                    children: [
                      CupertinoTextFormFieldRow(
                        prefix: const Text('Name'),
                        placeholder: 'Name',
                        controller: _nameController,
                      ),
                      CupertinoTextFormFieldRow(
                        prefix: const Text('Email'),
                        placeholder: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                      ),
                      CupertinoFormRow(
                        prefix: const Text('Gender: '),
                        child: CupertinoSlidingSegmentedControl(
                          groupValue: _gender,
                          children: {
                            'male': Text('Male'),
                            'female': Text('Female'),
                            'other': Text('Other'),
                          },
                          onValueChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                        ),
                      ),
                      CupertinoFormRow(
                        prefix: const Text('Birthday'),
                        child: CupertinoButton(
                          child: Text(
                            _birthday.toFormattedDate(),
                          ),
                          onPressed: () async {
                            await showCupertinoModalPopup(
                              context: context,
                              builder: (context) => Container(
                                color: CupertinoColors.systemBackground.resolveFrom(context),
                                height: 200,
                                child: SafeArea(
                                  top: false,
                                  child: CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.date,
                                    onDateTimeChanged: (value) {
                                      setState(() {
                                        _birthday = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  CupertinoFormSection.insetGrouped(
                    header: Text(
                      'Contact'.toUpperCase(),
                    ),
                    children: [
                      CupertinoFormRow(
                        prefix: const Text('Email Updates'),
                        child: CupertinoSwitch(
                          value: _emailUpdates,
                          onChanged: (value) {
                            setState(() {
                              _emailUpdates = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CupertinoFormSection.insetGrouped(
                    children: [
                      CupertinoListTile(
                        title: const Text(
                          'Delete Account',
                          style: TextStyle(
                            color: CupertinoColors.destructiveRed,
                          ),
                        ),
                        onTap: () {
                          Dialogs.showDeleteAccountDialog(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            onPressed: _togglePlatform,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text('Personal Information'),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Gender',
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'male',
                        child: Text('Male'),
                      ),
                      DropdownMenuItem(
                        value: 'female',
                        child: Text('Female'),
                      ),
                      DropdownMenuItem(
                        value: 'other',
                        child: Text('Other'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                    value: _gender,
                  ),
                  TextFormField(
                    controller: _birthdayController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Birthday',
                      helperText: 'DD.MM.YYYY',
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.calendar_month,
                          size: 24,
                        ),
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: _birthday,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );
                          setState(
                            () {
                              if (date != null) {
                                _birthday = date;
                                _birthdayController.text = _birthday.toFormattedDate();
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('Contact'),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Email Updates'),
                    value: _emailUpdates,
                    onChanged: (value) {
                      setState(() {
                        _emailUpdates = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FilledButton(
                        onPressed: () {},
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Dialogs.showDeleteAccountDialog(context);
                    },
                    child: Text(
                      'Delete Account',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _togglePlatform() {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
    } else {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    }

    // This rebuilds the application. This should obviously never be
    // done in a real app but it's done here since this app
    // unrealistically toggles the current platform for demonstration
    // purposes.
    WidgetsBinding.instance.reassembleApplication();
  }

  Future<UserModel> _getUser() async {
    final response = await rootBundle.loadString('supporting_files/user.json');
    final model = UserModel.fromJson(jsonDecode(response));

    setState(() {
      _user = model;
      _emailController.text = model.email;
      _nameController.text = model.name;
      _birthdayController.text = model.birthday;
      _gender = model.gender;
      _emailUpdates = model.emailUpdates;
      _birthday = DateTime.parse(model.birthday);
    });

    return model;
  }

  UserModel? _user;

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return FutureBuilder<UserModel>(
        future: _getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PlatformWidget(
              buildiOS: _buildiOS,
              buildAndroid: _buildAndroid,
            );
          } else {
            return PlatformWidget(
              buildiOS: _buildLoadingiOS,
              buildAndroid: _buildLoadingAndroid,
            );
          }
        },
      );
    } else {
      return PlatformWidget(
        buildiOS: _buildiOS,
        buildAndroid: _buildAndroid,
      );
    }
  }

  Widget _buildLoadingiOS(BuildContext context) {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }

  Widget _buildLoadingAndroid(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
