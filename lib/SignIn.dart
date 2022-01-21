import 'package:flutter/material.dart';
import 'package:flutter_application_1/authentication.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: "Email",
          ),
        ),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            labelText: "Password",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<AuthenticationService>().signIn(
                  email: emailController.text,
                  password: passwordController.text,
                );
          },
          child: Text("Sign In"),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<AuthenticationService>().signUp(
                  email: emailController.text,
                  password: passwordController.text,
                );
          },
          child: Text("Sign Up"),
        )
      ]),
    );
  }
}
