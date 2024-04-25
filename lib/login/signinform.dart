import 'package:flutter/material.dart';
import 'package:myapp/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _signIn() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    UserCredential? userCredential = await AuthService().signInWithEmailAndPassword(email, password);
    if (userCredential != null) {
      // Navigate to the home page upon successful sign-in
      Navigator.pushReplacementNamed(context,'/topics');
  
    } else {
      // Handle sign-in failure, e.g., display an error message
      // You can display an error message to the user or handle it according to your app's logic
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height:16),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height:16),
            ElevatedButton(
              onPressed: () => {
                _signIn(),
              }, 
              child: const Text("Sign in"),
            ),
          ],
        ),
      ),
    );
  }
}