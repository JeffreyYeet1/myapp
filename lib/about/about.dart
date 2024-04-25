import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("About"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Home"),
          onPressed: () => {
            // Use pop when going back so it removes this screen instead of adding another home screen
            Navigator.pop(context, '/'),
          },
        ),
      ),
    );
  }
}