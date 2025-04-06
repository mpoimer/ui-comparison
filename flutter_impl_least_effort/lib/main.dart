import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_impl_least_effort/app.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting('de_DE', null);

  runApp(const App());
}
