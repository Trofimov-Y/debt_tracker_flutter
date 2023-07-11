import 'package:auto_route/auto_route.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:debt_tracker/core/config/available_currencies.dart';
import 'package:debt_tracker/generated/l10n.dart';
import 'package:debt_tracker/presentation/extensions/build_context_extensions.dart';
import 'package:debt_tracker/presentation/extensions/text_style_extensions.dart';
import 'package:debt_tracker/presentation/pages/settings/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class SettingsPage extends StatelessWidget implements AutoRouteWrapper {
  const SettingsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<SettingsCubit>(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final cubit = context.read<SettingsCubit>();
          return CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverAppBar.large(
                title: Text(S.of(context).settings),
                leading: BackButton(onPressed: () => context.router.pop()),
              ),
              ...state.map(
                initial: (_) => [
                  const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  )
                ],
                success: (state) {
                  return [
                    SliverToBoxAdapter(
                      child: ListTile(
                        contentPadding: const EdgeInsets.only(left: 24, right: 24),
                        title: Text(
                          'Summary panel',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text('Show summary panel on home screen'),
                        trailing: Switch(
                          value: state.summaryEnabled,
                          onChanged: cubit.onSummaryStatusChanged,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: ListTile(
                        onTap: () {
                          showCurrencyPicker(
                            context: context,
                            showSearchField: false,
                            physics: const BouncingScrollPhysics(),
                            onSelect: (Currency currency) {
                              cubit.onSummaryCurrencyCodeChanged(currency.code);
                            },
                            currencyFilter: availableCurrencies,
                          );
                        },
                        contentPadding: const EdgeInsets.only(left: 24, right: 24),
                        title: Text(
                          'Summary currency',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text('Currency for summary panel'),
                        trailing: Text(
                          state.summaryCurrencyCode,
                          style: context.textTheme.bodyMedium?.medium,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: ListTile(
                        onTap: cubit.onSignOutTap,
                        contentPadding: const EdgeInsets.only(left: 28, right: 16),
                        title: Text(
                          S.of(context).logOut,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(S.of(context).signingOutAccount),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: ListTile(
                        onTap: cubit.onDeleteProfileTap,
                        contentPadding: const EdgeInsets.only(left: 28, right: 16),
                        title: Text(
                          S.of(context).deleteAccount,
                          style:
                              TextStyle(color: context.colors.error, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(S.of(context).existingDataDeleted),
                      ),
                    ),
                  ];
                },
                error: (_) => [
                  const SliverFillRemaining(
                    child: Center(child: Text('Error')),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
