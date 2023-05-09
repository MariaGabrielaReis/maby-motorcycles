import 'package:flutter/material.dart';

enum InputType {
  text,
  email,
  password,
  number,
  optional,
  CEP,
  UF
}

class Input extends StatefulWidget {
  final String label;
  final String placeholder;
  final Icon icon;
  final String? Function(String value, {InputType? type}) validator;
  final void Function(String value) onSaved; 
  final InputType inputType;

   const Input({ 
    Key? key, 
    required this.label,
    required this.placeholder,
    required this.icon,
    required this.validator,
    required this.onSaved,
    this.inputType = InputType.text,
  }) : super(key: key);

  @override  
   State<StatefulWidget> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    var inputKeyboardType = TextInputType.text;
    if(widget.inputType == InputType.CEP || widget.inputType == InputType.number) inputKeyboardType = TextInputType.number;
    if(widget.inputType == InputType.email) inputKeyboardType = TextInputType.emailAddress;
    if(widget.inputType == InputType.password) inputKeyboardType = TextInputType.visiblePassword;

    return TextFormField(
      onSaved: (String? value) => widget.onSaved(value ?? ''),
      keyboardType: inputKeyboardType,
      validator: 
        (String? value) => widget.validator(value ?? '', type: widget.inputType),
      decoration: InputDecoration(
        hintText: widget.placeholder, 
        border: OutlineInputBorder(),
        label: Text(widget.label),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal),
        ),
        prefixIcon: widget.icon,
      ),
      obscureText: widget.inputType == InputType.password,
    );
  }
}