import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  // Using a stream because we want the UI to react off auth state changes
  // However we don't know when those changes will happen
  final userStream = FirebaseAuth.instance.authStateChanges();
  // A stream: a way to listen to a sequence of asynchronous events

  // We can check a users auth state synchronously with currentUser
  final user = FirebaseAuth.instance.currentUser;

  // We are going to define an anonymous login that returns a void Future
  Future<void> anonLogin() async {
    // When trying to log users in its a good idea to wrap in a try catch
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      // handle error
    }
  }

  // Also would like to give them a sign out method
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> googleLogin() async {
    try {

      
      // Brings up a window on the users device which has them login to google
      final googleUser = await GoogleSignIn().signIn();

      // If theres nothing that comes from the login we can return early
      if(googleUser==null) return;

      // If there is a user then we await authentication object
      final googleAuth = await googleUser.authentication;

      // Use the authenication object to create credientials for firebase auth
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(authCredential);

    } on FirebaseAuthException catch (e) {
      // Handle error
    }
  }

String generateNonce([int length = 32]) {
  final charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(length, (_) => charset[random.nextInt(charset.length)])
      .join();
}

/// Returns the sha256 hash of [input] in hex notation.
String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

Future<UserCredential> signInWithApple() async {
  // To prevent replay attacks with the credential returned from Apple, we
  // include a nonce in the credential request. When signing in with
  // Firebase, the nonce in the id token returned by Apple, is expected to
  // match the sha256 hash of `rawNonce`.
  final rawNonce = generateNonce();
  final nonce = sha256ofString(rawNonce);

  // Request credential for the currently signed in Apple account.
  final appleCredential = await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ],
    nonce: nonce,
  );

  // Create an `OAuthCredential` from the credential returned by Apple.
  final oauthCredential = OAuthProvider("apple.com").credential(
    idToken: appleCredential.identityToken,
    rawNonce: rawNonce,
  );

  // Sign in the user with Firebase. If the nonce we generated earlier does
  // not match the nonce in `appleCredential.identityToken`, sign in will fail.
  return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
}

Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      print("Sign in with email and password failed: $e");
      return null;
    }
  }

}