import 'package:asiscumbre/src/app.dart';
import 'package:asiscumbre/src/preferences/config_preferences.dart';
import 'package:flutter/material.dart';

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = ConfigPreferences();
  await prefs.initPrefs();
  runApp(AppIVCumbre());
}
