import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NavigatorModule {
  @lazySingleton
  GlobalKey<NavigatorState> get navigatorState => GlobalKey<NavigatorState>();
}
