import 'package:auto_route/auto_route.dart';
import 'package:debt_tracker/generated/l10n.dart';
import 'package:debt_tracker/presentation/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

final tabs = ['Tab 1', 'Tab 2'];

@RoutePage()
class EntriesPage extends StatelessWidget implements AutoRouteWrapper {
  const EntriesPage({super.key});

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
                title: Text(S.of(context).entries),
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
                    SliverFixedExtentList(
                      itemExtent: 48.0,
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return ListTile(
                            title: Text('Item $index'),
                          );
                        },
                        childCount: 30,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: context.colors.surface,
                        height: context.mediaQuery.padding.bottom + 8,
                      ),
                    ),
                  ],
                );
              },
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add New Item',
        child: const Icon(Icons.add),
      ),
    );
  }
}
