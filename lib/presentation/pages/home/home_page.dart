import 'package:auto_route/auto_route.dart';
import 'package:debt_tracker/core/extensions/bool_extensions.dart';
import 'package:debt_tracker/presentation/pages/home/cubits/debts_feed/debts_feed_cubit.dart';
import 'package:debt_tracker/presentation/pages/home/cubits/debts_summary/debts_summary_cubit.dart';
import 'package:debt_tracker/presentation/pages/home/delegates/home_persistent_header_delegate.dart';
import 'package:debt_tracker/presentation/pages/home/utils/group_actions_util.dart';
import 'package:debt_tracker/presentation/pages/home/widgets/feed_action_list_tile.dart';
import 'package:debt_tracker/presentation/pages/home/widgets/header_actions_buttons.dart';
import 'package:debt_tracker/presentation/pages/home/widgets/header_status_bar.dart';
import 'package:debt_tracker/presentation/pages/home/widgets/header_values.dart';
import 'package:debt_tracker/presentation/pages/home/widgets/sticky_header_item.dart';
import 'package:debt_tracker/presentation/routing/app_router.dart';
import 'package:debt_tracker/presentation/widgets/empty/empty_state_widget.dart';
import 'package:debt_tracker/presentation/widgets/errors/error_state_widget.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:sliver_tools/sliver_tools.dart';

@RoutePage()
class HomePage extends StatelessWidget implements AutoRouteWrapper {
  const HomePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetIt.instance.get<DebtsFeedCubit>()),
        BlocProvider(create: (context) => GetIt.instance.get<DebtsSummaryCubit>()),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final debtsFeedCubit = context.watch<DebtsFeedCubit>();
        final debtsSummaryCubit = context.watch<DebtsSummaryCubit>();
        final gropedActions = groupActionsByDate(
          debtsFeedCubit.state.maybeMap(
            success: (state) => state.actions,
            orElse: () => const [],
          ),
        );

        return Scaffold(
          body: CustomScrollView(
            physics: gropedActions.isEmpty.when(
              () => const NeverScrollableScrollPhysics(),
              () => const BouncingScrollPhysics(),
            ),
            slivers: [
              SliverPinnedPersistentHeader(
                delegate: HomePersistentHeaderDelegate(
                  minExtentProtoType: debtsSummaryCubit.state.maybeMap(
                    success: (state) {
                      return Container(
                        height: 56 + MediaQuery.paddingOf(context).top,
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.only(bottom: 16),
                        child: HeaderStatusBar(
                          currencySymbol: NumberFormat.simpleCurrency(
                            name: state.summary.currencyCode,
                          ).currencySymbol,
                          owedByMe: state.summary.totalOwedByMe,
                          owedToMe: state.summary.totalOwedToMe,
                        ),
                      );
                    },
                    orElse: () => SizedBox(height: MediaQuery.paddingOf(context).top),
                  ),
                  maxExtentProtoType: Container(
                    height: debtsSummaryCubit.state.maybeMap(
                      success: (state) => 220 + MediaQuery.paddingOf(context).top,
                      orElse: () => 120 + MediaQuery.paddingOf(context).top,
                    ),
                    padding: const EdgeInsets.only(left: 24, right: 24, bottom: 20, top: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ...?debtsSummaryCubit.state.mapOrNull(
                          success: (state) {
                            return [
                              Expanded(
                                child: HeaderValues(
                                  currencySymbol: NumberFormat.simpleCurrency(
                                    name: state.summary.currencyCode,
                                  ).currencySymbol,
                                  owedByMe: state.summary.totalOwedByMe,
                                  owedToMe: state.summary.totalOwedToMe,
                                ),
                              ),
                            ];
                          },
                        ),
                        HeaderActionsButtons(
                          onNewDebtPressed: () {
                            context.router.push(const NewDebtRoute());
                          },
                          onAllEntriesPressed: () {
                            context.router.push(const AllDebtsRoute());
                          },
                          onSettingsPressed: () {
                            context.router.push(const SettingsRoute());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              debtsFeedCubit.state.map(
                initial: (_) => const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
                ),
                success: (state) {
                  if (gropedActions.isEmpty) {
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: EmptyStateWidget(
                        title: 'No actions yet',
                        message: 'Add a new debt to get started',
                      ),
                    );
                  }
                  return SliverClip(
                    child: MultiSliver(
                      children: List.generate(gropedActions.length, (index) {
                        final date = gropedActions.keys.elementAt(index);
                        final actions = gropedActions[date];
                        return SliverStickyHeader.builder(
                          builder: (context, state) {
                            return StickyHeaderItem(
                              dateTime: date,
                              isPinned: state.isPinned,
                              scrollPercentage: state.scrollPercentage,
                            );
                          },
                          sliver: SliverList.builder(
                            itemCount: actions!.length,
                            itemBuilder: (context, index) {
                              final action = actions[index];
                              return FeedActionListTile(onTap: () {}, action: action);
                            },
                          ),
                        );
                      }),
                    ),
                  );
                },
                error: (_) => SliverFillRemaining(
                  hasScrollBody: false,
                  child: ErrorStateWidget(onRetryPressed: debtsFeedCubit.onRetryPressed),
                ),
              ),
              SliverGap(MediaQuery.paddingOf(context).bottom + 8),
            ],
          ),
        );
      },
    );
  }
}
