import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_list_app/home_page.dart';
import 'package:task_list_app/pages/projects/_view/projects_page.dart';
import 'package:task_list_app/pages/tasks/_view/tasks_page.dart';
import 'package:task_list_app/pages/teams/_view/teams_page.dart';

enum HomePages {
  tasks,
  projects,
  teams,
}

extension HomePagesEx on HomePages {
  String get label {
    switch (this) {
      case HomePages.tasks:
        return "Tasks";
      case HomePages.projects:
        return "Projects";
      case HomePages.teams:
        return "Teams";
    }
  }

  String get path {
    switch (this) {
      case HomePages.tasks:
        return "/tasks";
      case HomePages.projects:
        return "/projects";
      case HomePages.teams:
        return "/teams";
    }
  }

  Widget get child {
    switch (this) {
      case HomePages.tasks:
        return TasksPage();
      case HomePages.projects:
        return ProjectsPage();
      case HomePages.teams:
        return TeamsPage();
    }
  }

  // GoRoutes
  List<GoRoute> get routes {
    switch (this) {
      case HomePages.tasks:
        return [
          GoRoute(
              path: "/:id",
              builder: (context, state) {
                return TaskDetails(taskId: state.pathParameters["id"]!);
              })
        ];

      case HomePages.projects:
      case HomePages.teams:
        return [];
    }
  }
}

class AppRouter {
  static final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>(debugLabel: "nav");
  static final GlobalKey<NavigatorState> _shellKey = GlobalKey<NavigatorState>(debugLabel: "shell");
  static GoRouter configure(BuildContext context) => GoRouter(
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
              builder: (context, state, child) {
                return HomePage(child: child);
              },
              routes: HomePages.values
                  .map((e) => GoRoute(
                        path: e.path,
                        builder: (context, state) => e.child,
                      ))
                  .toList()),
        ],
      );
}
