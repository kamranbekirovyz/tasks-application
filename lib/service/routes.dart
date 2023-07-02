import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_app/home_page.dart';
import 'package:task_list_app/model/task.dart';
import 'package:task_list_app/pages/projects/_view/projects_page.dart';
import 'package:task_list_app/pages/tasks/_view/tasks_detail_page.dart';
import 'package:task_list_app/pages/tasks/_view/tasks_page.dart';
import 'package:task_list_app/pages/teams/_view/teams_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/tasks',
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    /// Application shell
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return HomePage(child: child);
      },
      routes: <RouteBase>[
        /// The first screen to display in the bottom navigation bar.

        GoRoute(
          path: '/tasks',
          builder: (BuildContext context, GoRouterState state) {
            return const TasksPage();
          },
        ),
        GoRoute(
          path: '/tasks/:id',
          builder: (BuildContext context, GoRouterState state) {
            final id = state.pathParameters['id'];
            final tasklist = state.extra as List<Task>;
            final task = tasklist.firstWhere((t) => t.id == id);
            return TaskDetailPage(key: state.pageKey, task: task);
          },
        ),

        /// Displayed when the second item in the the bottom navigation bar is
        /// selected.
        GoRoute(
          path: '/projects',
          builder: (BuildContext context, GoRouterState state) {
            return const ProjectsPage();
          },
        ),

        /// The third screen to display in the bottom navigation bar.
        GoRoute(
          path: '/teams',
          builder: (BuildContext context, GoRouterState state) {
            return const TeamsPage();
          },
        ),
      ],
    ),
  ],
);
