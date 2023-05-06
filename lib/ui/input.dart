import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final String label;
  final Icon icon;
  final String? Function(String value, String field) validator;
  final void Function(String value) onSaved; 
  final TextInputType keyboardType;

   const Input({ 
    Key? key, 
    required this.label,
    required this.icon,
    required this.validator,
    required this.onSaved,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override  
   State<StatefulWidget> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (String? value) => widget.onSaved(value ?? ''),
      keyboardType: widget.keyboardType,
      validator: 
        (String? value) => widget.validator(value ?? '', widget.label),
      decoration: InputDecoration(
        hintText: 'Digite o ${widget.label}', 
        border: OutlineInputBorder(),
        label: Text(widget.label),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
        ),
        prefixIcon: widget.icon,
      ),
    );
  }
}