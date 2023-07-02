import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_app/common/app_style.dart';
import 'package:task_list_app/pages/tasks/_view/tasks_detail_page.dart';
import 'package:task_list_app/pages/tasks/notifiers/tasks_notifier.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TasksPage extends ConsumerWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksLists = ref.watch(tasksProvider);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 12, 10, 6),
            child: Text(
              AppLocalizations.of(context).tasks,
              style: TextStyle(fontSize: 24),
            ),
          ),
          const Divider(
            indent: 10,
            endIndent: 10,
            color: AppStyle.mediumBlue,
          ),
          Center(
            // TODO: labels should be in app localization file
            child: tasksLists.when(
              data: (data) => ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    onTap: () =>
                        context.go('/tasks/${data[index].id}', extra: data),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    tileColor: Colors.blueGrey[50],
                    title: Text(data[index].title ?? ''),
                    trailing: Text(data[index].dateTime.toString()),
                  ),
                ),
              ),
              error: (error, stackTrace) =>
                  Text('Failed to load tasks due to $error'),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
