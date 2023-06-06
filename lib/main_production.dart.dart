import 'package:debt_tracker/configuration/environment.dart';
import 'package:debt_tracker/main.dart' as app;
import 'package:flutter/material.dart' hide Notification;

void main() async {
  currentEnvironment = Environment.production;

  WidgetsFlutterBinding.ensureInitialized();
  // TODO Add Firebase Crashlytics

  app.main();
}
