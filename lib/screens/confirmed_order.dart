import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/ui/button.dart';

class ConfirmedOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bem vindo(a)!')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/main_logo.png',
              height: 150.0,
              fit: BoxFit.fitWidth,
            ),
            Text('Pedido confirmado!', style: TextStyle(fontSize: 18.0)),
            const SizedBox(height: 32.0),
            Button(
              label: 'Voltar', 
              onPress: () => Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => Home()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}