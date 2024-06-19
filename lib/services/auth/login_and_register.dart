import 'package:apb/pages/login_page.dart';
import 'package:apb/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginAndRegister extends StatefulWidget {
  const LoginAndRegister({super.key});

  @override
  _LoginAndRegisterState createState() => _LoginAndRegisterState();
}

class _LoginAndRegisterState extends State<LoginAndRegister> {
  //initially, show login page
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
      return LoginPage(
        onTap: togglePages
        );
    } else {
      return RegisterPage(
        onTap: togglePages
        );
    }
  }
}
