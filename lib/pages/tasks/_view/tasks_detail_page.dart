import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_app/common/app_style.dart';
import 'package:task_list_app/common/utils.dart';
import 'package:task_list_app/model/task.dart';

class TaskDetailPage extends StatelessWidget {
  final Task? task;
  const TaskDetailPage({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            IconButton(
                onPressed: () => context.pop(), icon: Icon(Icons.chevron_left)),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 12, 10, 6),
              child: Text(
                task!.title ?? '',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
        const Divider(
          indent: 10,
          endIndent: 10,
          color: AppStyle.mediumBlue,
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            formatDate(task!.dateTime!),
            style: TextStyle(color: Colors.grey[800]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            task!.description ?? '',
            softWrap: true,
          ),
        )
      ],
    );
  }
}
