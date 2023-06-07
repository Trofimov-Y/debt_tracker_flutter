import 'package:auto_route/auto_route.dart';
import 'package:debt_tracker/presentation/feautres/welcome/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'app_router.gr.dart';

@lazySingleton
@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  AppRouter(this.navigatorKey) : super(navigatorKey: navigatorKey);

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: WelcomeRoute.page, initial: true, path: '/'),
  ];
}
