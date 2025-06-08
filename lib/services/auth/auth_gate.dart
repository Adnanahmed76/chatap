import 'package:chatap/services/auth/login_or_register.dart';
import 'package:chatap/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance
          .authStateChanges(), // Listen to authentication state changes
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading screen while waiting for Firebase to fetch user data
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          // User is logged in, show HomeScreen
          return const HomePage();
        }

        // User is NOT logged in, show Login/Register screen
        return const LoginOrRegister();
      },
    );
  }
}
