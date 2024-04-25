import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/services/auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const FlutterLogo(
              size: 150,
            ),
            Flexible(
              child: LoginButton(
                icon: FontAwesomeIcons.userNinja,
                text: 'continue as guest',
                loginMethod: AuthService().anonLogin,
                color: Colors.deepPurple,
              ),
            ),
            Flexible(
              child: ElevatedButton.icon(
                onPressed: () => {
                  Navigator.pushNamed(context,'/signinform'),
                },
                icon: const Icon(
                  FontAwesomeIcons.envelope,
                  color: Colors.white,
                  size: 20,
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(24),
                  backgroundColor: Colors.blue,
                ),
                label: const Text('Sign in with Email', textAlign: TextAlign.center),
              ),
            ),
            Flexible(
              child: ElevatedButton(
                onPressed: () => {
                  Navigator.pushNamed(context, '/signupform'),
                },
                child: const Text('Create Account'),
              ),
            ),
            // Flexible(
            //   child: LoginButton(
            //     icon: FontAwesomeIcons.google,
            //     text: 'Sign in with Google',
            //     loginMethod: AuthService().googleLogin,
            //     color: Colors.blue,
            //   ),
            // ),
            // Flexible(
            //   child: LoginButton(
            //     icon: FontAwesomeIcons.apple,
            //     text: 'Sign in with Apple',
            //     loginMethod: AuthService().signInWithApple,
            //     color: Colors.black,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {

  // We can pass custom parameters by declaring the properties within the class
  // Then we can reference them in the constructor
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton(
    {Key? key, 
    required this.color,
    required this.icon,
    required this.text,
    required this.loginMethod})
      : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        onPressed: () => {
          loginMethod(),
        },
        icon: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(24),
          backgroundColor: color,
        ),
        label: Text(text, textAlign: TextAlign.center),
      ),
    );
  }
}