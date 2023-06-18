import 'package:auto_route/auto_route.dart';
import 'package:debt_tracker/presentation/pages/new_debt/new_debt_page.dart';
// ignore: directives_ordering
import 'package:debt_tracker/presentation/pages/entries/entries_page.dart';
import 'package:debt_tracker/presentation/pages/debt_details/debt_details_page.dart';
import 'package:debt_tracker/presentation/pages/home/home_page.dart';
import 'package:debt_tracker/presentation/pages/settings/settings_page.dart';
import 'package:debt_tracker/presentation/pages/start/start_page.dart';
import 'package:debt_tracker/presentation/pages/welcome/welcome_page.dart';
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
    CustomRoute(
      page: StartRoute.page,
      path: '/',
      initial: true,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      page: WelcomeRoute.page,
      path: '/welcome',
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      page: HomeRoute.page,
      path: '/home',
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    AutoRoute(page: EntriesRoute.page, path: '/entries'),
    AutoRoute(page: NewDebtRoute.page, path: '/add-entry'),
    AutoRoute(page: DebtDetailsRoute.page, path: '/entry-details'),
    AutoRoute(page: SettingsRoute.page, path: '/settings'),
  ];
}
