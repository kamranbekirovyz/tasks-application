import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_list_app/common/app_style.dart';
import 'package:task_list_app/config/router.dart';
import 'package:task_list_app/providers/routing_provider.dart';

class AppNavigationBar extends ConsumerWidget {
  const AppNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ColoredBox(
      color: AppStyle.darkBlue,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 64),
        itemCount: navigationBarItems.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            final page = HomePages.values[index];
            ref.read(routingProvider.notifier).state = page;
            context.go(page.path);
          },
          child: _NavigationBarListItem(
            item: navigationBarItems[index],
          ),
        ),
        separatorBuilder: (context, index) => Divider(
          color: AppStyle.mediumBlue,
          height: 1,
          endIndent: 16,
          indent: 16,
        ),
      ),
    );
  }
}

class _NavigationBarListItem extends ConsumerWidget {
  const _NavigationBarListItem({
    Key? key,
    required this.item,
  }) : super(key: key);
  final NavigationBarItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(routingProvider);
    return Consumer(
      builder: (context, ref, child) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: page.name.toLowerCase() == item.name.toLowerCase()
                ? AppStyle.orange
                : Colors.transparent,
          ),
          child: Text(
            item.name,
            style: TextStyle(
              color: AppStyle.lightTextColor,
              fontSize: 18,
            ),
          ),
        );
      },
    );
  }
}

final navigationBarItems = [
  // TODO: labels should be in app localization file
  NavigationBarItem(name: 'Tasks', url: 'tasks'),
  NavigationBarItem(name: 'Projects', url: 'projects'),
  NavigationBarItem(name: 'Teams', url: 'teams'),
];

class NavigationBarItem {
  final String name;
  final String url;

  NavigationBarItem({required this.name, required this.url});
}
