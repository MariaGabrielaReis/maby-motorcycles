
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/confirmed_order.dart';
import 'package:flutter_app/ui/button.dart';
import 'package:flutter_app/ui/checkbox.dart' as Custom;
import 'package:flutter_app/ui/input.dart';
import 'package:flutter_app/ui/product_card.dart';
import 'package:flutter_app/utils/validate_input.dart';
import 'package:flutter_app/models/motorcycle.dart';
import 'package:flutter_app/mocks/filters.dart';

class Cart extends StatefulWidget {
  final Motorcycle product;

  const Cart({ Key? key,  required this.product }): super(key: key);

  @override  
  State<StatefulWidget> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final _formKey = GlobalKey<FormState>();
  static final validator = InputValidator();
  var quantity = 1;
  var total = 0.0;

  List<String> selectedFilters = [];
  void _addFilter(String filter) {
    final filterIndex = selectedFilters.indexOf(filter);
    filterIndex > -1
      ? selectedFilters.remove(filter)
      : selectedFilters.add(filter);
  }

  void _send() {
     if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => ConfirmedOrder()),
      );
    }
  }

  void _calculate(double price){
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() => {
        total = quantity * price
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final fivePercentOfScreen = (MediaQuery.of(context).size.width / 100) * 5;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do pedido'),
        foregroundColor: Colors.teal,
        backgroundColor: Colors.transparent, 
        shadowColor: Colors.transparent, 
        iconTheme: IconThemeData(color: Colors.teal),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: fivePercentOfScreen,
          right: fivePercentOfScreen > 64 ? fivePercentOfScreen * 1.5 : fivePercentOfScreen,
          left: fivePercentOfScreen > 64 ? fivePercentOfScreen * 1.5 : fivePercentOfScreen,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            ProductCard(isCartProduct: true, motorcycle: widget.product),
            const SizedBox(height: 16.0),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Input(
                    label: 'Quantidade',
                    placeholder: 'Digite a quantidade',
                    inputType: InputType.number,
                    icon: const Icon(Icons.add_circle_outline_outlined),
                    validator: validator.validateText,
                    onSaved: (String value) => quantity = int.parse(value),
                  ),
                  // const SizedBox(height: 16.0), 
                  // const Divider(),
                  // const SizedBox(height: 16.0),  
                  // Text('Informações de entrega', style: TextStyle(fontSize: 16.0)),
                  // const SizedBox(height: 8.0),
                  // Custom.Checkbox(label: 'Retirar na loja', onPress: () => debugPrint('retirar')),
                  // Custom.Checkbox(label: 'Receber no meu endereço', onPress: () => debugPrint('receber')),
                  const SizedBox(height: 16.0), 
                  const Divider(),
                  const SizedBox(height: 16.0),  
                  Text('Deseja receber promoções dos nossos produtos?', style: TextStyle(fontSize: 16.0)),
                  const SizedBox(height: 8.0),
                  Column(
                    children: filters.map((filter) {
                      var isChecked = selectedFilters.indexOf(filter) > -1;
                      
                      return Custom.Checkbox(
                        label: filter, 
                        isChecked: isChecked, 
                        onPress: () {
                          _addFilter(filter);
                          setState(() {
                            isChecked = !isChecked;
                          });                  
                        }
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0), 
            const Divider(),
            const SizedBox(height: 16.0), 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('Total:', style: TextStyle(fontSize: 16.0)),
                    Text(' R\$ $total', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                  ]
                ),
                const SizedBox(height: 16.0),
                Button(
                  label: 'Calcular', 
                  type: ButtonTypes.outlined,
                  onPress: () => _calculate(widget.product.price),
                ),
              ],
            ), 
            const SizedBox(height: 16.0),
            const Divider(), 
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