import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_list_app/config/router.dart';
import 'package:task_list_app/home_page.dart';
import 'package:task_list_app/pages/projects/_view/projects_page.dart';
import 'package:task_list_app/pages/tasks/_view/tasks_page.dart';
import 'package:task_list_app/pages/teams/_view/teams_page.dart';
import 'package:task_list_app/providers/routing_provider.dart';
import 'package:task_list_app/providers/tasks_provider.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>(debugLabel: "nav");
  final GlobalKey<NavigatorState> _shellKey = GlobalKey<NavigatorState>(debugLabel: "shell");
  final GlobalKey<NavigatorState> _tasksKey = GlobalKey<NavigatorState>(debugLabel: "tasks");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Task list App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      routerConfig: GoRouter(
        redirect: (context, state) {
          if (state.location == "/") {
            return "/tasks";
          }
          return null;
        },
        initialLocation: "/tasks",
        navigatorKey: _navKey,
        routes: [
          ShellRoute(
            navigatorKey: _shellKey,
            pageBuilder: (context, state, child) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                ref.read(routingProvider.notifier).state = (HomePages.values.firstWhere(
                  (e) => e.path == state.location,
                  orElse: () => HomePages.tasks,
                ));
              });

              return NoTransitionPage(child: HomePage(child: child));
            },
            routes: [
              ShellRoute(
                navigatorKey: _tasksKey,
                builder: (context, state, child) {
                  return TasksPage();
                },
                routes: [
                  GoRoute(
                    path: "/tasks",
                    pageBuilder: (context, state) {
                      return NoTransitionPage(child: TasksPage());
                    },
                  ),
                  GoRoute(
                    path: "/tasks/:id",
                    pageBuilder: (context, state) {
                      if (state.pathParameters["id"] != null) {
                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                          ref.read(selectedTaskIdProvider.notifier).state =
                              state.pathParameters["id"];
                        });
                      }
                      return NoTransitionPage(child: TasksPage());
                    },
                  ),
                ],
              ),
              GoRoute(
                path: "/projects",
                builder: (context, state) => ProjectsPage(),
                routes: [],
              ),
              GoRoute(
                path: "/teams",
                builder: (context, state) => TeamsPage(),
                routes: [],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
