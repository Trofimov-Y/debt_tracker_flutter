import 'package:auto_route/auto_route.dart';
import 'package:debt_tracker/core/extensions/date_time_extensions.dart';
import 'package:debt_tracker/core/extensions/string_extensions.dart';
import 'package:debt_tracker/generated/l10n.dart';
import 'package:debt_tracker/presentation/extensions/build_context_extensions.dart';
import 'package:debt_tracker/presentation/pages/new_debt/cubit/new_debt_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class NewDebtPage extends StatelessWidget implements AutoRouteWrapper {
  const NewDebtPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<NewDebtCubit>(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewDebtCubit, NewDebtState>(
        builder: (context, state) {
          final cubit = context.read<NewDebtCubit>();
          return CustomScrollView(
            slivers: [
              SliverAppBar.large(
                leading: BackButton(
                  onPressed: () => context.router.pop(),
                ),
                title: Text(S.of(context).newDebt),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SegmentedButton<DebtType>(
                        onSelectionChanged: (value) => cubit.changeDebtType(value.first),
                        segments: [
                          ButtonSegment<DebtType>(
                            value: DebtType.toMe,
                            label: Text(S.of(context).owedToMe),
                          ),
                          ButtonSegment<DebtType>(
                            value: DebtType.byMe,
                            label: Text(S.of(context).owedByMe),
                          ),
                        ],
                        selected: {state.type},
                      ),
                      const Gap(32),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.add_call),
                            onPressed: () {},
                          ),
                          contentPadding: const EdgeInsets.only(
                            top: 8,
                            bottom: 8,
                            left: 16,
                            right: 12,
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      const Gap(32),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Count'),
                        textInputAction: TextInputAction.next,
                      ),
                      const Gap(32),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Description'),
                        textInputAction: TextInputAction.done,
                      ),
                      const Gap(32),
                      const Text('Date incurred'),
                      const Gap(4),
                      TextFormField(
                        readOnly: true,
                        controller: TextEditingController(
                          text: state.incurredDate.EEEddMMMYFormat.capitalizedEachFirstLetter,
                        ),
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: state.incurredDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          ).then((value) => value != null ? cubit.changeIncurredDate(value) : null);
                        },
                        decoration: const InputDecoration(
                          hintText: 'Select date',
                          suffixIcon: Icon(Icons.arrow_drop_down),
                          contentPadding: EdgeInsets.all(16),
                        ),
                      ),
                      const Gap(32),
                      const Text('Date due'),
                      const Gap(4),
                      TextFormField(
                        controller: TextEditingController(
                          text: state.dueDate?.EEEddMMMYFormat.capitalizedEachFirstLetter ?? '',
                        ),
                        readOnly: true,
                        onTap: () async {
                          showDatePicker(
                            context: context,
                            initialDate: state.dueDate ?? state.incurredDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          ).then((value) => value != null ? cubit.changeDueDate(value) : null);
                        },
                        decoration: const InputDecoration(
                          hintText: 'Select date',
                          suffixIcon: Icon(Icons.arrow_drop_down),
                          contentPadding: EdgeInsets.all(16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverGap(context.mediaQuery.padding.bottom + 8),
            ],
          );
        },
      ),
    );
  }
}
