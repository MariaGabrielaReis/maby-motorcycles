import 'package:flutter/material.dart';
import 'package:flutter_app/screens/signin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SignIn Form',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: SignIn(),
    );
  }
}

