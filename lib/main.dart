import 'package:flutter/material.dart';
import 'package:mathville/authentication/login.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mathville',
      theme: ThemeData(fontFamily: 'Inter'),
      home: const Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}
