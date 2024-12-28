import 'package:flutter/material.dart';
import 'package:gecko_cms/module/login/service/google_login_service.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            GoogleLoginService.signWebInWithGoogle();
          },
          child: Card(
            child: Padding(
                padding: EdgeInsets.all(10), child: Text("Login with google")),
          ),
        ),
      ),
    );
  }
}
