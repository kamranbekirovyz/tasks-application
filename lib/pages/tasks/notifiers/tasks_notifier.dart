import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_list_app/model/task.dart';
import 'package:task_list_app/service/network_service.dart';

final tasksProvider =
    StateNotifierProvider<TasksNotifier, AsyncValue<List<Task>>>(
        (ref) => TasksNotifier(ref));

class TasksNotifier extends StateNotifier<AsyncValue<List<Task>>> {
  final Ref ref;
  TasksNotifier(this.ref) : super(AsyncLoading()) {
    _init();
  }

  void _init() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final networkService = ref.read(networkServiceProvider);
      return await networkService.getTasks();
    });
  }
}
