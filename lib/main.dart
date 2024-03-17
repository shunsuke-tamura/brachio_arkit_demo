import 'package:brachio_arkit_demo/ar/helloworld.dart';
import 'package:brachio_arkit_demo/route_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(const MaterialApp(home: MyApp()));

// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const RouteListPage(),
    ),
    GoRoute(
      path: '/helloworld',
      builder: (context, state) => const ARKitHelloWorld(),
    ),
  ],
);

/// The main app.
class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
