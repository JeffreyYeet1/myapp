// This is a clean way of keep your routes in check

import 'package:myapp/about/about.dart';
import 'package:myapp/home/home.dart';
import 'package:myapp/profile/profile.dart';
import 'package:myapp/topics/topics.dart';
import 'package:myapp/login/login.dart';
import 'package:myapp/login/signupform.dart';
import 'package:myapp/login/signinform.dart';

// A map called appRoutes
var appRoutes = {
  // Maps a string value to the widget we want to route to and display
  // Key starts with a slash and then the name, except the root route which is only a slash
  '/': (context) => const HomeScreen(), // This widget will be pushed onto the stack
  '/login': (context) => const LoginScreen(),
  '/about': (context) => const AboutScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/topics': (context) => const TopicScreen(),
  '/signupform': (context) => SignUpForm(),
  '/signinform': (context) => SignInForm(),
};