import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_list_app/model/task.dart';

class TaskNotifier extends StateNotifier<Task?> {
  TaskNotifier(super.state);

  Task? selectedTask;

  void selectTask(Task task) {
    state = task;
  }
}
