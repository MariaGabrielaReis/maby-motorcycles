import 'package:flutter/material.dart';

class Switch extends StatefulWidget {
  final String label;
  final String description;
  final Function(bool? value) onPress;
  final bool isChecked;

  const Switch({ 
    Key? key, 
    required this.label,
    required this.description,
    required this.onPress,
    this.isChecked = true,
  }) : super(key: key);

  @override  
   State<StatefulWidget> createState() => _SwitchState();
}

class _SwitchState extends State<Switch> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      controlAffinity: ListTileControlAffinity.leading,
      visualDensity: VisualDensity.comfortable,
      title: Text(
        widget.label, style: 
        const TextStyle(fontSize: 14.0),
      ),
      subtitle: Text(widget.description),
      value: widget.isChecked,
      onChanged: widget.onPress,
      isThreeLine: true,
    );
  }
}




