import 'package:flutter/material.dart';
import 'package:flutter_app/screens/cart.dart';
import 'package:flutter_app/ui/button.dart';

class ProductCard extends StatefulWidget {
  final String name;
  final bool isCartProduct;

  const ProductCard({ 
    Key? key, 
    required this.name, 
    this.isCartProduct = false 
  }) : super(key: key);

  @override  
   State<StatefulWidget> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.motorcycle),
      title: Text(widget.name, style: TextStyle(fontSize: 12.0)),
      trailing:!widget.isCartProduct ? Button(
        type: ButtonTypes.outlined,
        label: 'comprar', 
        onPress: () => Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => Cart(productName: widget.name)),
        ), 
      ) : SizedBox.shrink(),
    );
  }
}