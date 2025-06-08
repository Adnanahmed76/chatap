import 'package:chatap/pages/login_screen.dart';
import 'package:chatap/pages/register_user.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //initially show login page

  bool showLoginPage = true;
  //toggle between login and register page

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(onTap: togglePages); // ✅ Pass togglePages
    } else {
      return RegisterUser(onTap: togglePages); // ✅ Pass togglePages
    }
  }
}
