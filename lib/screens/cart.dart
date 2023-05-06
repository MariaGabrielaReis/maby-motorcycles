
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/confirmed_order.dart';
import 'package:flutter_app/ui/button.dart';
import 'package:flutter_app/ui/input.dart';
import 'package:flutter_app/ui/product_card.dart';
import 'package:flutter_app/utils/validate_input.dart';

class Cart extends StatefulWidget {
  final String productName;

  const Cart({ Key? key,  required this.productName }): super(key: key);

  @override  
  State<StatefulWidget> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final _formKey = GlobalKey<FormState>();
  static final validator = InputValidator();
  var quantity = 1;

  void _send() {
     if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => ConfirmedOrder()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final fivePercentOfScreen = (MediaQuery.of(context).size.width / 100) * 5;

    return Scaffold(
      appBar: AppBar(title: const Text('Maby Motorcyles')),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: fivePercentOfScreen,
          horizontal: fivePercentOfScreen > 64 ? fivePercentOfScreen * 1.5 : fivePercentOfScreen,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Detalhes do pedido:', style: TextStyle(fontSize: 14.0)),
            const SizedBox(height: 16.0),
            ProductCard(name: widget.productName, isCartProduct: true),
            const SizedBox(height: 8.0),
            Form(
              key: _formKey,
              child: Input(
                label: 'Quantidade',
                icon: const Icon(Icons.add_circle_outline_outlined),
                validator: validator.validateText,
                onSaved: (String value) => quantity = int.parse(value),
              ),
            ),
            const SizedBox(height: 16.0),   
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Button(label: 'Enviar', onPress: () => _send()),
                Button(
                  label: 'Voltar', 
                  onPress: () => Navigator.pop(context), 
                  type: ButtonTypes.unfilled,
                ),
              ],
            ),    
          ],
        ),
      ),
    );
  }
}