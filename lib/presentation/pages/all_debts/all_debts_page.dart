import 'package:auto_route/auto_route.dart';
import 'package:debt_tracker/core/extensions/date_time_extensions.dart';
import 'package:debt_tracker/domain/entities/debt_entity.dart';
import 'package:debt_tracker/generated/l10n.dart';
import 'package:debt_tracker/presentation/extensions/build_context_extensions.dart';
import 'package:debt_tracker/presentation/extensions/text_style_extensions.dart';
import 'package:debt_tracker/presentation/pages/all_debts/cubit/all_debts_cubit.dart';
import 'package:debt_tracker/presentation/routing/app_router.dart';
import 'package:debt_tracker/presentation/widgets/empty/empty_state_widget.dart';
import 'package:debt_tracker/presentation/widgets/errors/error_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

part 'widgets/debts_tab_list.dart';

@RoutePage()
class AllDebtsPage extends StatelessWidget implements AutoRouteWrapper {
  const AllDebtsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<AllDebtsCubit>(),
      child: DefaultTabController(length: 2, child: this),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AllDebtsCubit>();
    return Scaffold(
      body: BlocBuilder<AllDebtsCubit, AllDebtsState>(
        builder: (context, state) {
          return NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    title: Text(S.of(context).allDebts),
                    floating: true,
                    snap: true,
                    pinned: true,
                    actions: state.mapOrNull(
                      success: (_) => [
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            //TODO: implement search later
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {
                            //TODO: implement more actions later
                          },
                        ),
                      ],
                    ),
                    forceElevated: innerBoxIsScrolled,
                    bottom: state.mapOrNull(
                      success: (_) => TabBar(
                        tabs: [
                          Tab(text: S.of(context).owedToMe),
                          Tab(text: S.of(context).owedByMe),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: Builder(
              builder: (context) {
                return state.when(
                  initial: () => const Center(child: CircularProgressIndicator()),
                  error: (_) => Center(
                    child: ErrorStateWidget(
                      onRetryPressed: cubit.onRetryPressed,
                    ).animate().fadeIn(),
                  ),
                  success: (toMeDebts, owedByMeDebts) {
                    return TabBarView(
                      children: [
                        _DebtsTabList(
                          pageStorageKey: const PageStorageKey('toMe'),
                          debts: toMeDebts,
                          onTileTap: (String debtId) {},
                        ),
                        _DebtsTabList(
                          pageStorageKey: const PageStorageKey('owedByMe'),
                          debts: owedByMeDebts,
                          onTileTap: (String debtId) {},
                        ),
                      ],
                    ).animate().fadeIn();
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(const NewDebtRoute());
        },
        tooltip: S.of(context).newDebt,
        child: const Icon(Icons.add),
      ),
    );
  }
}
