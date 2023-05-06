
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/product_card.dart';

class Home extends StatefulWidget {
  @override  
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final products = [
    'Haojue DK 200 \nR\$ 13.000', 
    'Honda CG 150 \nR\$ 18.000',
    'Honda CBX 250 \nR\$ 25.000',
    'Suzuki Intruder 125 \nR\$ 11.000',
  ];

  @override
  Widget build(BuildContext context) {
    final fivePercentOfScreen = (MediaQuery.of(context).size.width / 100) * 5;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Maby Motorcyles'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: fivePercentOfScreen,
          horizontal: fivePercentOfScreen > 64 ? fivePercentOfScreen * 1.5 : fivePercentOfScreen,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bem vindo(a)!',
              style: TextStyle(fontSize: 18.0, color: Colors.teal),
            ),
            const SizedBox(height: 16.0),
            ListView.separated(
              shrinkWrap: true,
              itemCount: products.length,
              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 4.0),
              itemBuilder: (BuildContext context, int index) {
                return ProductCard(name: products[index]);
              },
            ),     
          ],
        ),
      ),
    );
  }
}