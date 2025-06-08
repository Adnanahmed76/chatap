import 'package:chatap/services/auth/auth_services.dart';
import 'package:chatap/component/my_button.dart';
import 'package:chatap/component/texrfiled.dart';
import 'package:chatap/pages/home_page.dart';
import 'package:chatap/pages/login_screen.dart';
import 'package:flutter/material.dart';

class RegisterUser extends StatelessWidget {
  final void Function()? onTap;
  // Add this line
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confrompassword = TextEditingController();

  RegisterUser({super.key, this.onTap}); // <-- Add this constructor param
  void register(BuildContext context) {
    //get auth service
    final _auth = AuthServices();
    //password matched ->create user
    if (_passwordController.text == _confrompassword.text) {
      try {
        _auth.signUpWithEmailPassword(
            _emailController.text.trim(), _passwordController.text.trim());
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        print("User registered successfully");
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    }
    //password don't match-> show erro to user
    else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("password Don't match"),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 150.0),
          child: Center(
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
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16),
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
                MyTextfiled(
                    hintext: "Confrom Password",
                    obscureText: true,
                    controller: _confrompassword),
                SizedBox(
                  height: 15,
                ),
                MyButton(
                  text: "Register",
                  onTap: () => register(context), // Ensure login is called
                ),
                SizedBox(
                  height: 8,
                ),
                // Register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an Account?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "login",
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
