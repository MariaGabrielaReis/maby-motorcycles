import 'package:flutter/material.dart';

enum ButtonTypes {
  filled,
  unfilled,
  outlined,
  favorite,
  withIcon
}

class Button extends StatefulWidget {
  final String label;
  final Function onPress;
  final ButtonTypes type;
  final IconData? icon;
  final bool isFullWidth;

  const Button({ 
    Key? key, 
    required this.label,
    required this.onPress,
    this.type = ButtonTypes.filled,
    this.icon = Icons.menu,
    this.isFullWidth = false,
  }) : super(key: key);

  @override  
   State<StatefulWidget> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  var isFavorite = false;

  void _pressIcon() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(
          !isFavorite 
          ? 'Adicionado à lista de desejos!' 
          : 'Removido da lista de desejos!'
        ),
      ),
    );

    setState(() {
      isFavorite = !isFavorite;
    });

    widget.onPress();
  }

  @override
  Widget build(BuildContext context) {
    final defaultWidth = MediaQuery.of(context).size.width / 3;
    var buttonWidth = defaultWidth > 200 ? 200 : defaultWidth;

    if(widget.isFullWidth) buttonWidth = MediaQuery.of(context).size.width;
    if(widget.type == ButtonTypes.favorite) buttonWidth = 24.0;

    if(widget.type == ButtonTypes.withIcon) return withIcon();

    return SizedBox(
      height:  widget.type == ButtonTypes.favorite ? 24.0 : 32.0,
      width: buttonWidth.toDouble(),
      child: buildButton(),
    );
  }

  Widget buildButton() {
    if(widget.type == ButtonTypes.filled) return filled();
    if(widget.type == ButtonTypes.unfilled) return unfilled();
    if(widget.type == ButtonTypes.favorite) return favorite();
    if(widget.type == ButtonTypes.outlined) return outlined();
    
    return SizedBox.shrink();
  }

  Widget withIcon() {
    return TextButton(
      onPressed: () => widget.onPress(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.icon, size: 18.0, color: Colors.grey[800]),
          const SizedBox(width: 8.0),
          Text(widget.label, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800])),
        ],
      ),
    );
  }

  Widget filled() {
    return ElevatedButton(
      onPressed: () => widget.onPress(), 
      child: Text(widget.label),
    );
  }
  
  Widget unfilled() {
    return TextButton(
      onPressed: () => widget.onPress(),
      child: Text(widget.label),
    );
  }

  Widget favorite() {
    return IconButton(
      onPressed: () => _pressIcon(),
      color: Colors.teal,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(0.0),
      splashRadius: 18.0,
      iconSize: 24.0,
      icon: isFavorite ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border_outlined),
    );
  }

  Widget outlined() {
    return OutlinedButton(
      onPressed: () => widget.onPress(),
      child: Text(widget.label),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.teal, width: 1.5),
        textStyle: const TextStyle(
          color: Colors.teal,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}