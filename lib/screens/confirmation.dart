import 'package:flutter/material.dart';
import 'package:flutter_app/ui/button.dart';

class Confirmation extends StatelessWidget {
  final String name, email, address, number, complement, uf, cep;

  const Confirmation({ Key? key, 
    required this.name, 
    required this.email,
    required this.address, 
    required this.number,
    required this.complement,
    required this.uf,
    required this.cep,
    }): super(key: key);

  @override
  Widget build(BuildContext context) {
    final tenPercentOfScreen = (MediaQuery.of(context).size.width / 100) * 10;

    return Scaffold(
      appBar: AppBar(title: const Text('Bem vindo(a)!')),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: tenPercentOfScreen/2,
          horizontal: tenPercentOfScreen > 64 ? tenPercentOfScreen * 1.5 : tenPercentOfScreen,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            Center(
              child: Text(
                'Olá, $name!',
                style: TextStyle(fontSize: 18.0, color: Colors.teal),
              ),
            ),
            const SizedBox(height: 32.0),
            Text('Confirme os dados abaixo:', style: TextStyle(fontSize: 14.0)),
            const SizedBox(height: 16.0),
            Text(
              'E-mail: $email \nEndereço: $address \nNúmero: $number \nComplemento: $complement \nUF: $uf \nCEP: $cep', 
              style: TextStyle(fontSize: 14.0, color: Colors.grey),
            ),
            const SizedBox(height: 32.0),
            Center(
              child: Button(
                label: 'Confirmar', 
                onPress: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: const Text('Dados confirmados!'))
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}