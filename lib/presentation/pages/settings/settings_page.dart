import 'package:auto_route/auto_route.dart';
import 'package:debt_tracker/generated/l10n.dart';
import 'package:debt_tracker/presentation/extensions/build_context_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SettingsPage extends StatelessWidget implements AutoRouteWrapper {
  const SettingsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar.large(
            title: Text(S.of(context).settings),
            leading: BackButton(
              onPressed: () => context.router.pop(),
            ),
          ),
          SliverToBoxAdapter(
            child: ListTile(
              onTap: () {},
              leading: const Icon(Icons.account_balance_wallet_outlined),
              contentPadding: const EdgeInsets.only(left: 28, right: 16),
              title: Text(S.of(context).mainCurrency),
              subtitle: Text(S.of(context).currencyForAllEntries),
            ),
          ),
          SliverToBoxAdapter(
            child: ListTile(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              leading: const Icon(Icons.logout),
              contentPadding: const EdgeInsets.only(left: 28, right: 16),
              title: Text(S.of(context).logOut),
              subtitle: Text(S.of(context).signingOutAccount),
            ),
          ),
          SliverToBoxAdapter(
            child: ListTile(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              leading: const Icon(Icons.delete_forever_outlined),
              contentPadding: const EdgeInsets.only(left: 28, right: 16),
              title: Text(
                S.of(context).deleteAccount,
                style: TextStyle(color: context.colors.error),
              ),
              subtitle: Text(S.of(context).existingDataDeleted),
            ),
          ),
        ],
      ),
    );
  }
}
