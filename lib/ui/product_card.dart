import 'package:flutter/material.dart';
import 'package:flutter_app/screens/cart.dart';
import 'package:flutter_app/ui/button.dart';
import 'package:flutter_app/models/motorcycle.dart';

class ProductCard extends StatefulWidget {
  final Motorcycle motorcycle;
  final bool isCartProduct;

  const ProductCard({ 
    Key? key, 
    required this.motorcycle, 
    this.isCartProduct = false 
  }) : super(key: key);

  @override  
   State<StatefulWidget> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
   

  @override
  Widget build(BuildContext context) {
    final item = widget.motorcycle;
       
    return Row(
      children: [
        Image.asset(item.image!, width: 100.0),
        const SizedBox(width: 24.0),  
        Expanded(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name, 
                      maxLines: 1,
                      style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4.0),
                    Text('R\$ ${item.price} \nQuant. disponível: ${item.quantity}', style: TextStyle(fontSize: 12.0)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            !widget.isCartProduct ? 
              Align(
                alignment: Alignment.bottomRight,
                child: Button(
                  type: ButtonTypes.outlined,
                  label: 'comprar', 
                  onPress: () => Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => Cart(product: item)),
                  ),
                ),
              ) : SizedBox.shrink(),
            ],
          )
        )      
      ],
    );
  }
}