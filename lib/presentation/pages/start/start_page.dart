import 'package:auto_route/auto_route.dart';
import 'package:debt_tracker/presentation/pages/start/cubits/authentication/authentication_cubit.dart';
import 'package:debt_tracker/presentation/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class StartPage extends StatelessWidget implements AutoRouteWrapper {
  const StartPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
      value: GetIt.instance.get<AuthenticationCubit>(),
      child: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          state.mapOrNull(
            authenticated: (_) {
              context.router.replaceAll([const HomeRoute()], updateExistingRoutes: false);
            },
            unauthenticated: (_) {
              context.router.replaceAll([const WelcomeRoute()], updateExistingRoutes: false);
            },
          );
        },
        child: this,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Icon(Icons.home, size: 120)),
    );
  }
}
