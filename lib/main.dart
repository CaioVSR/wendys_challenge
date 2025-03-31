import 'package:flutter/material.dart';
import 'package:wendys_challenge/app/app_injections.dart';
import 'package:wendys_challenge/app/main_app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppInjections().setUp();

  runApp(const MainAppWidget());
}
