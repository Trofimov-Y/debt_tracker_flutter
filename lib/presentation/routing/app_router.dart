import 'package:auto_route/auto_route.dart';
import 'package:debt_tracker/presentation/pages/home/home_page.dart';
import 'package:debt_tracker/presentation/pages/sing_in/sing_in_page.dart';
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
  RouteType get defaultRouteType => RouteType.custom(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: Tween<double>(begin: 1.0, end: 0.0).animate(
              CurvedAnimation(parent: secondaryAnimation, curve: Curves.fastOutSlowIn),
            ),
            child: SlideTransition(
              position: Tween<Offset>(begin: Offset.zero, end: const Offset(-0.2, 0.0)).animate(
                CurvedAnimation(parent: secondaryAnimation, curve: Curves.fastOutSlowIn),
              ),
              child: FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
                ),
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.2, 0.0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
                  child: child,
                ),
              ),
            ),
          );
        },
      );

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: StartRoute.page, path: '/', initial: true),
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
    AutoRoute(page: SignInRoute.page, path: '/sign_in'),
  ];
}
