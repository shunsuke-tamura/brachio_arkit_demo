import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteListPage extends StatelessWidget {
  const RouteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route List'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('HelloWorld'),
            onTap: () => context.go('/helloworld'),
          ),
          ListTile(
            title: const Text('Plane Detection'),
            onTap: () => context.go('/plane_detection'),
          ),
        ],
      ),
    );
  }
}
