import 'package:flutter/material.dart';
import 'package:login_api/screens/login_screen/login_screen.dart';
import 'package:login_api/screens/register_screen/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "login",
      routes: {
        "login": (context) => const LoginScreen(),
        "register": (context) => RegisterScreen(),
      },
    );
  }
}
