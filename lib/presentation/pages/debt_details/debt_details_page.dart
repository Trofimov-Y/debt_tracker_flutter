import 'package:auto_route/auto_route.dart';
import 'package:debt_tracker/generated/l10n.dart';
import 'package:debt_tracker/presentation/pages/debt_details/cubit/debt_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class DebtDetailsPage extends StatelessWidget implements AutoRouteWrapper {
  const DebtDetailsPage({super.key, required this.debtId});

  final String debtId;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<DebtDetailsCubit>(param1: debtId),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DebtDetailsCubit, DebtDetailsState>(
      builder: (context, state) {
        final cubit = context.read<DebtDetailsCubit>();
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar.large(
                leading: BackButton(
                  onPressed: () => context.router.pop(),
                ),
                actions: [
                  IconButton(
                    onPressed: cubit.onDeletePressed,
                    icon: const Icon(Icons.delete),
                  ),
                  const Gap(8),
                ],
                title: Text(S.of(context).debtDetails),
              ),
              ...state.map(
                initial: (_) => [
                  const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
                ],
                success: (state) {
                  return [
                    SliverToBoxAdapter(
                      child: TextFormField(
                        controller: TextEditingController(text: state.debt.name),
                        readOnly: true,
                      ),
                    ),
                    const SliverGap(16),
                    SliverToBoxAdapter(
                      child: TextFormField(initialValue: state.debt.description),
                    ),
                    const SliverGap(16),
                    SliverToBoxAdapter(
                      child: TextFormField(
                        controller: TextEditingController(text: state.debt.amount.toString()),
                      ),
                    ),
                  ];
                },
                error: (_) => [
                  const SliverFillRemaining(
                    child: Center(
                      child: Text('Error'),
                    ),
                  )
                ],
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: cubit.onEditPressed,
            child: const Icon(Icons.money),
          ),
        );
      },
    );
  }
}
