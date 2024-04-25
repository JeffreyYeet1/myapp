import 'package:flutter/material.dart';
import 'package:myapp/login/login.dart';
import 'package:myapp/topics/topics.dart';
import 'package:myapp/services/auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // This stream is the asynchronous stream we initalized in our auth.dart file
      stream: AuthService().userStream,
      builder: (context, snapshot) {

        // Checking different states of the snapshot. A snapshot is the current state of data
        if(snapshot.connectionState == ConnectionState.waiting){
          // Waiting on a connection
          return const Text("loading");
        } else if (snapshot.hasError) {
          // Has an error logging in
          return const Center(child: Text("Error"));
        } else if (snapshot.hasData) {
          // Successfully logged in if there is data
          return const TopicScreen(); 
        } else {
          // No data was detected, login unsuccessful
          return const LoginScreen();
        }
      },
    );
  }
}