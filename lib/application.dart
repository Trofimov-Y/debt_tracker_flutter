import 'package:debt_tracker/presentation/routing/app_router.dart';
import 'package:debt_tracker/presentation/routing/app_router_observer.dart';
import 'package:debt_tracker/presentation/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get_it/get_it.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: darkTheme,
        routerConfig: GetIt.instance.get<AppRouter>().config(
          navigatorObservers: () {
            return [GetIt.instance.get<AppRouterObserver>()];
          },
        ),
      ),
    );
  }
}
