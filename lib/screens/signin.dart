
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/create_account.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/ui/button.dart';
import 'package:flutter_app/ui/input.dart';
import 'package:flutter_app/utils/validate_input.dart';

class SignIn extends StatefulWidget {
  @override  
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  static var email = '', password = '';
  static final validator = InputValidator();

  void _sendForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tenPercentOfScreen = (MediaQuery.of(context).size.width / 100) * 10;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: tenPercentOfScreen/2,
          horizontal: tenPercentOfScreen > 64 ? tenPercentOfScreen * 1.5 : tenPercentOfScreen,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/main_logo.png',
                height: 150.0,
                fit: BoxFit.fitWidth,
              ),
              const Text(
                'Entre ou crie sua conta!',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 32.0),
              Input(
                label: 'E-mail',
                icon: const Icon(Icons.email_outlined),
                validator: validator.validateText,
                onSaved: (String value) => email = value,
              ),
              const SizedBox(height: 8.0),
              Input(
                label: 'Senha',
                icon: const Icon(Icons.password),
                validator: validator.validateText,
                onSaved: (String value) => password = value,
              ),
              const SizedBox(height: 16.0),
              Button(label: 'Entrar', onPress: () => _sendForm(), isFullWidth: true),
              const SizedBox(height: 8.0),
              Button(
                label: 'Criar conta', 
                onPress: () => Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => CreateAccount()),
                ), 
                type: ButtonTypes.outlined,
                isFullWidth: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}