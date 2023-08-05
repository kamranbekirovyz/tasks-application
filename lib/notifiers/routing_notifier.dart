import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_list_app/config/router.dart';

class RoutingNotifier extends StateNotifier<HomePages> {
  RoutingNotifier(super.state);

  void updateRoute(HomePages page) {
    state = page;
  }
}
