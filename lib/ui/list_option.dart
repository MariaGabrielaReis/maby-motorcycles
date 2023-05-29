import 'package:flutter/material.dart';

class ListOption extends StatefulWidget {
  final String label;
  final IconData icon;
  final Function onPress;

  const ListOption({ 
    Key? key, 
    required this.label,
    required this.icon,
    required this.onPress,
  }) : super(key: key);

  @override  
   State<StatefulWidget> createState() => _ListOptionState();
}

class _ListOptionState extends State<ListOption> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:Icon(widget.icon, size: 24.0),
      title: Text(widget.label),
      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20.0),      
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
      visualDensity: VisualDensity.comfortable,
      onTap: () => widget.onPress(),
    );
  }
}
