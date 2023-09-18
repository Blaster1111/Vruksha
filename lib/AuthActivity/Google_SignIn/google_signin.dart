import 'package:flutter/material.dart';
import 'package:vruksha/AuthActivity/Google_SignIn/auth_services.dart';

class Google_SignIn extends StatelessWidget {
  const Google_SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Google sign in"),
        ),
        body: Center(
            child: ElevatedButton(
          onPressed: () {
            authService.hangleSignIn(context);
          },
          child: Text("google sign in",
              style: TextStyle(
                color: Colors.purple,
              )),
        )));
  }
}
