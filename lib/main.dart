import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'auth/login_page.dart';

void main() {
  runApp(const RegistrationApp());
}

class RegistrationApp extends StatelessWidget {
  const RegistrationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue
      ),
      home: LoginPage(),
    );
  }
}
