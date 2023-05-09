import 'package:flutter/material.dart';
import 'package:flutter_app/screens/signin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maby Motorcycles',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: SignIn(),
    );
  }
}

