import 'package:flutter/material.dart';
import 'package:backend_flutter/screens/login/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Backend App',
      theme: ThemeData(
        primaryColor: Colors.black,
        cursorColor: Colors.black45,
      ),
      home: LoginScreen(),
    );
  }
}
