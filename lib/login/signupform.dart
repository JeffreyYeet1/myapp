import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/services/auth.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reEnterPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  String _errorMsg = '';

  Future<void> createAccountWithEmailAndPassword() async {
    setState((){
      _isLoading = true;
      _errorMsg = '';
    });

    try {
      final UserCredential userCredential = 
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(), 
          password: _passwordController.text
        );
        Navigator.pushReplacementNamed(context, '/topics');
        print('User account created: ${userCredential.user!.uid}');
    } catch (e) {
      setState((){
        _isLoading = false;
        _errorMsg = 'Failed to create account: $e';   
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height:16),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height:16),
            TextFormField(
              controller: _reEnterPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Re-Enter Password'),
            ),
            if (_errorMsg.isEmpty)
              Container(padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  _errorMsg,
                  style: const TextStyle(color: Colors.transparent),
                ),),
            if (_errorMsg.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  _errorMsg,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ElevatedButton(
              onPressed: () => {
                if(_isLoading){
                  null
                } else if (_passwordController.text.length < 6) {
                  setState (() {
                    _errorMsg = 'Password must contain atleast 6 characters!';
                  }),
                }
                else if (_passwordController.text != _reEnterPasswordController.text) {
                  setState (() {
                    _errorMsg = 'Passwords do not match!';
                  }),
                } else {
                  createAccountWithEmailAndPassword(),
                }
              }, 
              child: const Text("Create Account"),
            ),
          ],
        ),
      ),
    );
  }
}