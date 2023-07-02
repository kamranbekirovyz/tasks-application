import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_app/common/app_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationBarItems = [
      // TODO: labels should be in app localization file
      NavigationBarItem(
          name: AppLocalizations.of(context).tasks, url: '/tasks'),
      NavigationBarItem(
          name: AppLocalizations.of(context).projects, url: '/projects'),
      NavigationBarItem(
          name: AppLocalizations.of(context).teams, url: '/teams'),
    ];
    return ColoredBox(
      color: AppStyle.darkBlue,
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 64),
        itemCount: navigationBarItems.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            GoRouter.of(context).go(navigationBarItems[index].url);
          },
          child: _NavigationBarListItem(
            item: navigationBarItems[index],
            isSelected: GoRouter.of(context).location ==
                    navigationBarItems[index].url ||
                GoRouter.of(context)
                    .location
                    .contains(navigationBarItems[index].url),
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

class _NavigationBarListItem extends StatelessWidget {
  const _NavigationBarListItem({
    Key? key,
    required this.item,
    required this.isSelected,
  }) : super(key: key);
  final NavigationBarItem item;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFD8A50B) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          item.name,
          style: TextStyle(
            color: AppStyle.lightTextColor,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class NavigationBarItem {
  final String name;
  final String url;

  NavigationBarItem({required this.name, required this.url});
}
