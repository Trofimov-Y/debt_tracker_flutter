import 'package:auto_route/auto_route.dart';
import 'package:dartx/dartx.dart';
import 'package:debt_tracker/core/extensions/bool_extensions.dart';
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
import 'package:flutter/rendering.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

part 'widgets/debts_tab_list.dart';

@RoutePage()
class AllDebtsPage extends StatefulWidget implements AutoRouteWrapper {
  const AllDebtsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<AllDebtsCubit>(),
      child: DefaultTabController(length: 2, child: this),
    );
  }

  @override
  State<AllDebtsPage> createState() => _AllDebtsPageState();
}

class _AllDebtsPageState extends State<AllDebtsPage> {
  late final ScrollController _scrollController;

  bool _canShowFab = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_listen);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listen);
    _scrollController.dispose();
    super.dispose();
  }

  void _listen() {
    final ScrollDirection direction = _scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      _showFab();
    } else if (direction == ScrollDirection.reverse) {
      _hideFab();
    }
  }

  void _showFab() {
    if (!_canShowFab) {
      setState(() => _canShowFab = true);
    }
  }

  void _hideFab() {
    if (_canShowFab) {
      setState(() => _canShowFab = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AllDebtsCubit>();
    return Scaffold(
      body: BlocBuilder<AllDebtsCubit, AllDebtsState>(
        builder: (context, state) {
          return NestedScrollView(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    title: Text(S.of(context).allDebts),
                    floating: true,
                    snap: true,
                    pinned: true,
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
                          onTileTap: (String debtId) {
                            context.router.push(DebtDetailsRoute(debtId: debtId));
                          },
                        ),
                        _DebtsTabList(
                          pageStorageKey: const PageStorageKey('owedByMe'),
                          debts: owedByMeDebts,
                          onTileTap: (String debtId) {
                            context.router.push(DebtDetailsRoute(debtId: debtId));
                          },
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
      floatingActionButton: _canShowFab.when(
        () => FloatingActionButton(
          onPressed: () => context.router.push(const NewDebtRoute()),
          tooltip: S.of(context).newDebt,
          child: const Icon(Icons.add),
        ),
        () => null,
      ),
    );
  }
}
