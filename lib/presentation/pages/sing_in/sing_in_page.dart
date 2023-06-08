import 'package:auto_route/auto_route.dart';
import 'package:debt_tracker/core/assets/svg_assets.dart';
import 'package:debt_tracker/presentation/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

@RoutePage()
class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome back')),
      body: LayoutBuilder(
        builder: (context, constrains) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            height: constrains.maxHeight,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Gap(32),
                      OutlinedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(SvgAssets.googleIcon, width: 20, height: 20),
                            const Gap(8),
                            const Flexible(child: Text('Continue with Google')),
                          ],
                        ),
                      ),
                      const Gap(24),
                      const Divider(),
                      const Gap(32),
                      const TextField(decoration: InputDecoration(labelText: 'Email')),
                      const Gap(24),
                      const TextField(decoration: InputDecoration(labelText: 'Password')),
                    ],
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Gap(32),
                            const Text('Have you forgotten your password?'),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: TextButton(
                                onPressed: () {},
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.restore),
                                    Gap(8),
                                    Text('Reset password'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      FilledButton(onPressed: () {}, child: const Text('Log in')),
                      Gap(context.mediaQuery.padding.bottom + 40)
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
