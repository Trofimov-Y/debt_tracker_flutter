import 'package:auto_route/auto_route.dart';
import 'package:dartx/dartx.dart';
import 'package:debt_tracker/core/extensions/date_time_extensions.dart';
import 'package:debt_tracker/core/extensions/string_extensions.dart';
import 'package:debt_tracker/domain/entities/debt_entity.dart';
import 'package:debt_tracker/generated/l10n.dart';
import 'package:debt_tracker/presentation/extensions/build_context_extensions.dart';
import 'package:debt_tracker/presentation/pages/new_debt/cubit/new_debt_cubit.dart';
import 'package:debt_tracker/presentation/validation/text_fields_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class NewDebtPage extends StatefulWidget implements AutoRouteWrapper {
  const NewDebtPage({super.key});

  @override
  State<NewDebtPage> createState() => _NewDebtPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<NewDebtCubit>(),
      child: this,
    );
  }
}

class _NewDebtPageState extends State<NewDebtPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewDebtCubit, NewDebtState>(
        builder: (context, state) {
          final cubit = context.read<NewDebtCubit>();
          return CustomScrollView(
            slivers: [
              SliverAppBar.large(
                leading: const BackButton(),
                actions: [
                  FilledButton(
                    onPressed: state.maybeMap(
                      loading: (_) => null,
                      orElse: () => () {
                        if (_formKey.currentState?.validate() ?? false) {
                          cubit.onCreatePressed(
                            name: _nameController.text,
                            description: _descriptionController.text,
                            amount: _amountController.text.toDouble(),
                          );
                        }
                      },
                    ),
                    child: Text(S.of(context).create),
                  ),
                  const Gap(16),
                ],
                title: Text(S.of(context).newDebt),
                bottom: state.mapOrNull(
                  loading: (_) => const PreferredSize(
                    preferredSize: Size.fromHeight(4),
                    child: LinearProgressIndicator(),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                sliver: SliverToBoxAdapter(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SegmentedButton<DebtType>(
                          onSelectionChanged: (value) => cubit.changeDebtType(value.first),
                          segments: [
                            ButtonSegment<DebtType>(
                              enabled: state.maybeMap(loading: (_) => false, orElse: () => true),
                              value: DebtType.toMe,
                              label: Text(S.of(context).owedToMe),
                            ),
                            ButtonSegment<DebtType>(
                              enabled: state.maybeMap(loading: (_) => false, orElse: () => true),
                              value: DebtType.byMe,
                              label: Text(S.of(context).owedByMe),
                            ),
                          ],
                          selected: {state.type},
                        ),
                        const Gap(32),
                        TextFormField(
                          enabled: state.mapOrNull(loading: (_) => false),
                          decoration: InputDecoration(labelText: S.of(context).name),
                          textInputAction: TextInputAction.next,
                          controller: _nameController,
                          validator: nameValidator(S.of(context).cantBeEmpty),
                        ),
                        const Gap(32),
                        TextFormField(
                          enabled: state.mapOrNull(loading: (_) => false),
                          decoration: InputDecoration(labelText: S.of(context).amount),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,

                          inputFormatters: [
                            //TODO Add decimal formatter
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          controller: _amountController,
                          validator: amountValidator(
                            S.of(context).cantBeEmpty,
                            S.of(context).mustBeGreaterThanZero,
                          ),
                        ),
                        const Gap(32),
                        TextFormField(
                          enabled: state.mapOrNull(loading: (_) => false),
                          decoration: InputDecoration(labelText: S.of(context).description),
                          textInputAction: TextInputAction.done,
                          maxLength: 255,
                          maxLines: 10,
                          minLines: 1,
                          maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
                          controller: _descriptionController,
                        ),
                        const Gap(32),
                        Text(S.of(context).incurredDate),
                        const Gap(4),
                        TextFormField(
                          enabled: state.mapOrNull(loading: (_) => false),
                          readOnly: true,
                          controller: TextEditingController(
                            text: state.incurredDate.EEEddMMMYFormat.capitalizedEachFirstLetter,
                          ),
                          onTap: () {
                            final now = DateTime.now();
                            showDatePicker(
                              context: context,
                              initialDate: state.incurredDate,
                              firstDate: DateTime(now.year - 10),
                              lastDate: DateTime(now.year + 10),
                            ).then(
                              (value) => value != null ? cubit.changeIncurredDate(value) : null,
                            );
                          },
                          decoration: InputDecoration(
                            hintText: S.of(context).selectDate,
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            contentPadding: const EdgeInsets.all(16),
                          ),
                        ),
                        const Gap(32),
                        Text(S.of(context).dueDate),
                        const Gap(4),
                        TextFormField(
                          enabled: state.mapOrNull(loading: (_) => false),
                          controller: TextEditingController(
                            text: state.dueDate?.EEEddMMMYFormat.capitalizedEachFirstLetter ?? '',
                          ),
                          readOnly: true,
                          onTap: () async {
                            showDatePicker(
                              context: context,
                              initialDate: state.incurredDate,
                              firstDate: state.incurredDate,
                              lastDate: DateTime(DateTime.now().year + 10),
                            ).then((value) => value != null ? cubit.changeDueDate(value) : null);
                          },
                          decoration: InputDecoration(
                            hintText: S.of(context).selectDate,
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            contentPadding: const EdgeInsets.all(16),
                          ),
                        ),
                      ],
                    ),
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
