import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_list_app/common/constants.dart';
import 'package:task_list_app/model/task.dart';

final networkServiceProvider = Provider<NetworkService>((ref) {
  return NetworkService();
});

class NetworkService {
  NetworkService();

  Future<List<Task>> getTasks() async {
    final now = DateTime.now();
    return [
      Task(
          id: '1',
          title: 'Read emails from mailbox',
          description: descriptionText,
          dateTime: now),
      Task(
          id: '2',
          title: 'Check latest news on Flutter',
          description: descriptionText,
          dateTime: now),
      Task(
          id: '3',
          title: 'Have a call with Flutter team',
          description: descriptionText,
          dateTime: now),
      Task(
          id: '4',
          title: 'Work on application performance',
          description: descriptionText,
          dateTime: now),
      Task(
          id: '5',
          title: 'Plan work for next week',
          description: descriptionText,
          dateTime: now),
      Task(
          id: '6',
          title: 'Order lunch',
          description: descriptionText,
          dateTime: now),
      Task(
          id: '7',
          title: 'Create an invoice for last month',
          description: descriptionText,
          dateTime: now),
    ];
  }
}
