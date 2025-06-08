import 'package:chatap/services/auth/auth_services.dart';
import 'package:chatap/component/my_button.dart';
import 'package:chatap/component/texrfiled.dart';
import 'package:chatap/pages/register_user.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Updated constructor to remove unused onTap or use it as necessary
  LoginScreen({
    super.key,
    required void Function() onTap,
  });

  void login(BuildContext context) async {
    print("login button clicked");
    // Get the email and password entered by the user
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    // Check if email and password are not empty
    if (email.isEmpty || password.isEmpty) {
      // Show an alert dialog if fields are empty
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please enter both email and password'),
        ),
      );
      return;
    }

    // Auth services
    final authServices = AuthServices();

    // Try to sign in with email and password
    try {
      await authServices.signInWithEmailPassword(email, password);
    } catch (e) {
      // Catch any errors and show them in an AlertDialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(
              height: 50,
            ),

            // Welcome back message
            Text(
              "Welcome back, you've been missed",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 16),
            ),
            SizedBox(
              height: 25,
            ),

            // Email TextField
            MyTextfiled(
              controller: _emailController,
              hintext: "Email",
              obscureText: false,
            ),

            SizedBox(
              height: 15,
            ),
            // Password TextField
            MyTextfiled(
              controller: _passwordController,
              hintext: "Password",
              obscureText: true,
            ),

            // Login button
            SizedBox(
              height: 15,
            ),
            MyButton(
              text: "Login",
              onTap: () => login(context), // Ensure login is called
            ),
            SizedBox(
              height: 8,
            ),
            // Register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a Member?",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  width: 3,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterUser()));
                  },
                  child: Text(
                    " Register Now",
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
