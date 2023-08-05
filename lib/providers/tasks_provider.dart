import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_list_app/service/network_service.dart';

final tasksProvider = FutureProvider((ref) async {
  return await NetworkService().getTasks();
});

final selectedTaskIdProvider = StateProvider<String?>((ref) => null);

final taskByIdProvider = FutureProvider.family((ref, String id) async {
  return await NetworkService().getTaskById(id);
});
