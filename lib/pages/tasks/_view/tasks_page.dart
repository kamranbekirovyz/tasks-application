import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:task_list_app/model/task.dart';
import 'package:task_list_app/providers/tasks_provider.dart';

class TasksPage extends ConsumerWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Task>> asyncTasks = ref.watch(tasksProvider);

    return Center(
      // TODO: labels should be in app localization file
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tasks",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.black),
                  ),
                  Divider(color: Colors.blue.shade700),
                  Expanded(
                    child: asyncTasks.when(data: (data) {
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 50),
                        itemBuilder: (context, index) {
                          final task = data[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              onTap: () {
                                context.go("/tasks/${task.id}");
                                // ref.read(selectedTaskIdProvider.notifier).state = task.id;
                              },
                              tileColor: Colors.grey.shade200,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              title: Text(
                                task.title ?? "",
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: ref.watch(selectedTaskIdProvider) == task.id
                                        ? FontWeight.bold
                                        : FontWeight.w500),
                              ),
                              trailing: Text(
                                  DateFormat("dd/MM, hh:mm")
                                      .format(task.dateTime ?? DateTime.now()),
                                  style: TextStyle(color: Colors.grey.shade900)),
                            ),
                          );
                        },
                        itemCount: data.length,
                      );
                    }, error: (error, _) {
                      return SizedBox();
                    }, loading: () {
                      return CircularProgressIndicator();
                    }),
                  ),
                ],
              ),
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              final taskId = ref.watch(selectedTaskIdProvider);
              log("Task ID: $taskId");
              return taskId == null
                  ? SizedBox.shrink()
                  : VerticalDivider(
                      width: 10,
                      color: Colors.black.withOpacity(0.15),
                      thickness: 3,
                    );
            },
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                final taskId = ref.watch(selectedTaskIdProvider);
                return taskId == null ? SizedBox.shrink() : TaskDetails(taskId: taskId);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TaskDetails extends ConsumerWidget {
  const TaskDetails({
    required this.taskId,
    super.key,
  });

  final String taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Task?> asyncTask = ref.watch(taskByIdProvider(taskId));
    return asyncTask.when(
      data: (data) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: data == null
              ? Center(
                  child:
                      Text("No such task found!", style: Theme.of(context).textTheme.displayMedium))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title!,
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.black),
                    ),
                    Divider(color: Colors.blue.shade700),
                    SizedBox(height: 100),
                    Text(DateFormat("dd/MM, hh:mm").format(data.dateTime ?? DateTime.now()),
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.grey.shade600)),
                    Text(
                      data.description ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.black, fontSize: 18.0),
                    ),
                  ],
                ),
        );
      },
      error: (error, stackTrace) => Text("Error: $error"),
      loading: () => CircularProgressIndicator(),
    );
  }
}
