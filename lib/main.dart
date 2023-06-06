import 'dart:async';
import 'dart:developer';

import 'package:debt_tracker/application.dart';
import 'package:debt_tracker/observers/app_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
    // TODO Add error reporting with Firebase Crashlytics
  };

  Bloc.observer = AppBlocObserver();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ),
  );

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runZonedGuarded(
    () => runApp(const Application()),
    (error, stack) {
      log(error.toString(), stackTrace: stack);
      // TODO Add error reporting with Firebase Crashlytics
    },
  );
}
