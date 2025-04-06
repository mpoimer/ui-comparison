import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_impl_least_effort/user_model.dart';
import 'package:flutter_impl_least_effort/utils/date_formatter.dart';
import 'package:flutter_impl_least_effort/utils/dialogs.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<SettingsScreen> {
  String _gender = 'other';
  bool _emailUpdates = true;
  DateTime _birthday = DateTime.now();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
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
                  SwitchListTile.adaptive(
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
            return _buildContent(context);
          } else {
            return _buildLoading(context);
          }
        },
      );
    } else {
      return _buildContent(context);
    }
  }

  Widget _buildLoading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
