import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'testPages/cam_test.dart';
import 'testPages/home_test.dart';

void main() {
  runApp(const MainApp());
}

final GoRouter _router = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePageTest();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'camera_test_page',
          builder: (BuildContext context, GoRouterState state) {
            return const CameraTestPage();
          },
        ),
      ])
]);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
