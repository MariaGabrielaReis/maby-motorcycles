import 'package:flutter/material.dart';

enum ButtonTypes {
  filled,
  unfilled
}

class Button extends StatefulWidget {
  const Button({ 
    Key? key, 
    required this.label,
    required this.onPress,
    this.type = ButtonTypes.filled,
  }) : super(key: key);

  final String label;
  final Function onPress;
  final ButtonTypes type;

  @override  
   State<StatefulWidget> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 3;
  
    return SizedBox(
      height: 32.0,
      width: width > 200 ? 200 : width,
      child: widget.type == ButtonTypes.filled 
      ? ElevatedButton(
        onPressed: () => widget.onPress(), 
        child: Text(widget.label),
      ) 
      : TextButton(
        onPressed: () => widget.onPress(),
        child: Text(widget.label),
      ), 
    );
  }
}