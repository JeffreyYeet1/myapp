import 'package:flutter/material.dart';
import 'package:myapp/shared/bottom_nav.dart';

class TopicScreen extends StatelessWidget {
  const TopicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Topics'),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}