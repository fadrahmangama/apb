import 'package:apb/services/login_and_register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:apb/pages/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
          // User is logged in
            return const HomePage();
          } 

          // User is NOT logged in
          else {
            return LoginAndRegister(); // Remove 'const' here
          }
        },
      ), // StreamBuilder
    ); // Scaffold
  }
}
