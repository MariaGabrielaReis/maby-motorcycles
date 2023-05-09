import 'package:flutter/material.dart';

class Checkbox extends StatefulWidget {
  final String label;
  final Function onPress;
  final bool isChecked;

  const Checkbox({ 
    Key? key, 
    required this.label,
    required this.onPress,
    this.isChecked = false,
  }) : super(key: key);

  @override  
   State<StatefulWidget> createState() => _CheckboxState();
}

class _CheckboxState extends State<Checkbox> {
  @override
  Widget build(BuildContext context) {
    return  CheckboxListTile(
      contentPadding: const EdgeInsets.only(left: 24.0, top: 0.0, bottom: 0.0),
      controlAffinity: ListTileControlAffinity.leading,
      visualDensity: VisualDensity.comfortable,
      title: Text(widget.label, style: const TextStyle(color: Colors.grey)),
      value: widget.isChecked,
      onChanged: (bool? value) => widget.onPress(),
    );
  }
}
