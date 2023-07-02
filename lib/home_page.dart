import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_list_app/app_navigation_bar.dart';
import 'package:task_list_app/common/locale_notifier.dart';
import 'package:task_list_app/common/utils.dart';

// This class does not have to be used. It should be replaced with class
// handling navigation using go_router package

class HomePage extends StatelessWidget {
  final Widget child;
  const HomePage({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 200, maxWidth: 300),
            child: AppNavigationBar(),
          ),
          Expanded(child: child),
          Consumer(
            builder: (context, ref, child) {
              return Align(
                alignment: Alignment.topRight,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PopupMenuButton<SupportedLocale>(
                      itemBuilder: (context) {
                        return SupportedLocale.values
                            .map<PopupMenuEntry<SupportedLocale>>(
                                (e) => PopupMenuItem(
                                      child: Text('${e.name}'),
                                      value: e,
                                    ))
                            .toList();
                      },
                      onSelected: (locale) {
                        ref
                            .read(localeProvider.notifier)
                            .changeLanguage(locale);
                      },
                    )),
              );
            },
          ),
        ],
      ),
    );
  }
}
