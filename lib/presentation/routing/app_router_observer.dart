import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@lazySingleton
class AppRouterObserver extends AutoRouterObserver {
  final Logger _routingLogger = Logger(printer: PrettyPrinter());

  @override
  void didPush(Route route, Route? previousRoute) {
    _routingLogger.d('New route pushed: ${route.settings.name}');
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _routingLogger.v('Route poped: ${route.settings.name}');
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    _routingLogger.d('Route removed: ${route.settings.name}');
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _routingLogger.d(
      'Route replaced: from ${oldRoute?.settings.name} to ${newRoute?.settings.name}',
    );
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    _routingLogger.d('Tab route initialized: ${route.name}');
    super.didInitTabRoute(route, previousRoute);
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    _routingLogger.d('Tab route changed: from ${previousRoute.name} to ${route.name}');
    super.didChangeTabRoute(route, previousRoute);
  }
}
