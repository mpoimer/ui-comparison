import 'package:flut_impl/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting('de_DE', null);

  debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

  runApp(const App());
}
