import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:debt_tracker/generated/l10n.dart';
import 'package:debt_tracker/presentation/extensions/build_context_extensions.dart';
import 'package:debt_tracker/presentation/pages/home/home_page.test.dart';
import 'package:debt_tracker/presentation/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

final tabs = ['Tab 1', 'Tab 2'];

@RoutePage()
class AllDebtsPage extends StatelessWidget implements AutoRouteWrapper {
  const AllDebtsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return DefaultTabController(length: 2, child: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                title: Text(S.of(context).allDebts),
                floating: true,
                snap: true,
                pinned: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
                forceElevated: innerBoxIsScrolled,
                bottom: TabBar(
                  tabs: [
                    Tab(text: S.of(context).owedToMe),
                    Tab(text: S.of(context).owedByMe),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          children: tabs.map((name) {
            return Builder(
              builder: (context) {
                return CustomScrollView(
                  key: PageStorageKey<String>(name),
                  slivers: <Widget>[
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    ),
                    SliverList.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: const EdgeInsets.only(
                            left: 24,
                            top: 8,
                            bottom: 8,
                            right: 16,
                          ),
                          leading: CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(
                              'https://picsum.photos/seed/$index/48/48',
                            ),
                          ),
                          title: Text(
                            commonNames[Random().nextInt(commonNames.length)],
                          ),
                          trailing: Text(
                            (-index * 1000.0).toStringAsFixed(2),
                            style: context.textTheme.bodyLarge,
                          ),
                          onTap: () {
                            context.router.push(const DebtDetailsRoute());
                          },
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (index.isOdd || index > 5) ...[
                                Text(
                                  commonDebtDescriptions[Random().nextInt(
                                    commonDebtDescriptions.length,
                                  )],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Borrowed: ',
                                      style: context.textTheme.bodySmall?.copyWith(
                                        color: context.colors.secondary,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '18 Jun 2023',
                                      style: context.textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              if (index.isEven) ...[
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Due: ',
                                        style: context.textTheme.bodySmall?.copyWith(
                                          color: context.colors.secondary,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '23 Jun 2023',
                                        style: context.textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                      itemCount: 10,
                    ),
                    SliverGap(context.mediaQuery.padding.bottom)
                  ],
                );
              },
            );
          }).toList(),
        ),
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
