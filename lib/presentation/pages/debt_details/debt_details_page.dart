import 'package:auto_route/auto_route.dart';
import 'package:debt_tracker/generated/l10n.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DebtDetailsPage extends StatelessWidget implements AutoRouteWrapper {
  const DebtDetailsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            leading: BackButton(
              onPressed: () => context.router.pop(),
            ),
            title: Text(S.of(context).debtDetails),
          ),
          SliverFillRemaining(
            child: Center(
              child: Text(S.of(context).debtDetails),
            ),
          ),
        ],
      ),
    );
  }
}
