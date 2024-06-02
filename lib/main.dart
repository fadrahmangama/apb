import 'package:apb/auth/login_and_register.dart';
import 'package:apb/pages/register_page.dart';
import 'package:apb/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/login_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Aplikasi APB",
      home: const LoginAndRegister(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
