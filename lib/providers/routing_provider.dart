import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_list_app/config/router.dart';

final routingProvider = StateProvider<HomePages>((ref) => HomePages.tasks);
