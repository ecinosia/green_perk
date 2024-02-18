import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePageTest extends StatelessWidget {
  const HomePageTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test HomePage'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => context.go('/camera_test_page'),
            child: const Text(
              'Camera Test Page',
            ),
          ),
        ],
      ),
    );
  }
}
