import 'package:auto_route/auto_route.dart';
import 'package:debt_tracker/core/assets/lottie_assets.dart';
import 'package:debt_tracker/core/assets/svg_assets.dart';
import 'package:debt_tracker/generated/l10n.dart';
import 'package:debt_tracker/presentation/errors/failure_localization_extension.dart';
import 'package:debt_tracker/presentation/extensions/build_context_extensions.dart';
import 'package:debt_tracker/presentation/extensions/text_style_extensions.dart';
import 'package:debt_tracker/presentation/pages/welcome/cubits/welcome/welcome_cubit.dart';
import 'package:debt_tracker/presentation/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class WelcomePage extends StatelessWidget implements AutoRouteWrapper {
  const WelcomePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<WelcomeCubit>(),
      child: BlocListener<WelcomeCubit, WelcomeState>(
        listener: (BuildContext context, state) {
          state.mapOrNull(
            success: (_) => context.router.replaceAll([const HomeRoute()]),
            error: (state) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.failure.message(context))),
              );
            },
          );
        },
        child: this,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WelcomeCubit>();
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: kToolbarHeight + context.mediaQuery.padding.top + 32,
                left: 0,
                right: 0,
                child: Container(
                  constraints: BoxConstraints(maxHeight: constraints.maxHeight * 0.5),
                  child: Lottie.asset(LottieAssets.financeGuru),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                    maxHeight: constraints.maxHeight - context.mediaQuery.padding.top,
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      left: 40,
                      right: 40,
                      top: 32,
                      bottom: context.mediaQuery.padding.bottom + 32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          S.of(context).welcome,
                          style: context.textTheme.titleLarge?.medium,
                          textAlign: TextAlign.center,
                        ),
                        const Gap(12),
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            Text(
                              S.of(context).appName,
                              style: context.textTheme.titleLarge?.withColor(
                                context.colors.primary,
                              ),
                            ),
                            Text(
                              ' - ${S.of(context).subAppName}',
                              style: context.textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const Gap(24),
                        BlocBuilder<WelcomeCubit, WelcomeState>(
                          builder: (context, state) {
                            return AnimatedCrossFade(
                              firstChild: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  OutlinedButton(
                                    onPressed: cubit.onContinueWithGooglePressed,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          SvgAssets.googleIcon,
                                          width: 20,
                                          height: 20,
                                        ),
                                        const Gap(8),
                                        Flexible(child: Text(S.of(context).continueWithGoogle)),
                                      ],
                                    ),
                                  ),
                                  const Gap(16),
                                  TextButton(
                                    onPressed: cubit.onSignAsGuestPressed,
                                    child: Text(S.of(context).singAsGuest),
                                  ),
                                ],
                              ),
                              secondChild: const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 32),
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              crossFadeState: state.maybeMap(
                                orElse: () => CrossFadeState.showFirst,
                                loading: (_) => CrossFadeState.showSecond,
                              ),
                              duration: const Duration(milliseconds: 300),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
