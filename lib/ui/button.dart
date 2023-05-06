import 'package:flutter/material.dart';

enum ButtonTypes {
  filled,
  unfilled,
  outlined
}

class Button extends StatefulWidget {
  final String label;
  final Function onPress;
  final ButtonTypes type;
  final bool isFullWidth;

  const Button({ 
    Key? key, 
    required this.label,
    required this.onPress,
    this.type = ButtonTypes.filled,
    this.isFullWidth = false,
  }) : super(key: key);

  @override  
   State<StatefulWidget> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    final defaultWidth = MediaQuery.of(context).size.width / 3;
    final buttonWidth = widget.isFullWidth 
      ? MediaQuery.of(context).size.width 
      : defaultWidth > 200 ? 200 : defaultWidth;
  
    return SizedBox(
      height: 32.0,
      width: buttonWidth.toDouble(),
      child: widget.type == ButtonTypes.filled 
      ? ElevatedButton(
        onPressed: () => widget.onPress(), 
        child: Text(widget.label),
      ) 
      : widget.type == ButtonTypes.unfilled
      ? TextButton(
        onPressed: () => widget.onPress(),
        child: Text(widget.label),
      ) 
      : OutlinedButton(
        onPressed: () => widget.onPress(),
        child: Text(widget.label),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.teal, width: 1.5),
          textStyle: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}