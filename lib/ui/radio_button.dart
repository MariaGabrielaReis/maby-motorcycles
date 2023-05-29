import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  final String label;
  final String group;
  final Function onPress;
  final bool isChecked;

  const RadioButton({ 
    Key? key, 
    required this.label,
    required this.group,
    required this.onPress,
    this.isChecked = false,
  }) : super(key: key);

  @override  
   State<StatefulWidget> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      contentPadding: const EdgeInsets.only(left: 24.0, top: 0.0, bottom: 0.0),
      controlAffinity: ListTileControlAffinity.leading,
      visualDensity: VisualDensity.comfortable,
      title: Text(widget.label, style: const TextStyle(color: Colors.grey)),
      value: widget.label, 
      selected: widget.isChecked,
      groupValue: widget.group,
      onChanged: (String? value) => widget.onPress(),
    );
  }
}




