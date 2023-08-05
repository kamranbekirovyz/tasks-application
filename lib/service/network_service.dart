import 'package:hooks_riverpod/hooks_riverpod.dart';
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
        dateTime: now,
        description: loremEpsum(200),
      ),
      Task(
        id: '2',
        title: 'Check latest news on Flutter',
        dateTime: now,
        description: loremEpsum(200),
      ),
      Task(
        id: '3',
        title: 'Have a call with Flutter team',
        dateTime: now,
        description: loremEpsum(200),
      ),
      Task(
        id: '4',
        title: 'Work on application performance',
        dateTime: now,
        description: loremEpsum(200),
      ),
      Task(
        id: '200',
        title: 'Plan work for next week',
        dateTime: now,
        description: loremEpsum(200),
      ),
      Task(
        id: '6',
        title: 'Order lunch',
        dateTime: now,
        description: loremEpsum(200),
      ),
      Task(
        id: '7',
        title: 'Create an invoice for last month',
        dateTime: now,
        description: loremEpsum(200),
      ),
    ];
  }

  Future<Task?> getTaskById(String id) async {
    final tasks = await getTasks();
    final filtered = tasks.where((element) => element.id == id);
    return filtered.isNotEmpty ? filtered.first : null;
  }
}

// generate lorem epsum
String loremEpsum(int lines) {
  final lorem = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
      'Sed non risus. Suspendisse lectus tortor, dignissim sit amet, '
      'adipiscing nec, ultricies sed, dolor. Cras elementum ultrices diam. '
      'Maecenas ligula massa, varius a, semper congue, euismod non, mi. '
      'Proin porttitor, orci nec nonummy molestie, enim est eleifend mi, '
      'non fermentum diam nisl sit amet erat. Duis semper. Duis arcu massa, '
      'scelerisque vitae, consequat in, pretium a, enim. Pellentesque congue. '
      'Ut in risus volutpat libero pharetra tempor. Cras vestibulum bibendum '
      'augue. Praesent egestas leo in pede. Praesent blandit odio eu enim. '
      'Pellentesque sed dui ut augue blandit sodales. Vestibulum ante ipsum '
      'primis in faucibus orci luctus et ultrices posuere cubilia Curae; '
      'Aliquam nibh. Mauris ac mauris sed pede pellentesque fermentum. '
      'Maecenas adipiscing ante non diam sodales hendrerit.';

  final words = lorem.split(' ');
  final result = <String>[];
  for (var i = 0; i < lines; i++) {
    result.add(words[i % words.length]);
  }
  return result.join(' ');
}
