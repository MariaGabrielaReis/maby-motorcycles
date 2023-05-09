import 'package:flutter/material.dart';
import 'package:flutter_app/ui/button.dart';
import 'package:flutter_app/ui/checkbox.dart' as Custom;

class FiltersModal extends StatefulWidget {
  final List<String> filters;
  final List<String> selectedFilters;
  final Function(String filter) onSelectFilter;
  final Function onFilter;

  const FiltersModal({ 
    Key? key, 
    required this.filters,
    required this.selectedFilters,
    required this.onSelectFilter, 
    required this.onFilter, 
  }) : super(key: key);

  @override  
   State<StatefulWidget> createState() => _FiltersModalState();
}

class _FiltersModalState extends State<FiltersModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
      decoration: BoxDecoration(
        borderRadius:BorderRadius.vertical(top: Radius.circular(25.0)),
        color: Colors.white,
      ),
      child: Wrap(
        runSpacing: 16.0,
        children: [
          const Text(
            'Produtos', 
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          Column(
            children: widget.filters.map((filter) {
              var isChecked = widget.selectedFilters.indexOf(filter) > -1;

              return Custom.Checkbox(
                label: filter, 
                isChecked: isChecked,
                onPress: () {
                  widget.onSelectFilter(filter);
                  setState(() {
                    isChecked = !isChecked;
                  });                  
                },
              );
            }).toList(),
          ),
          Button(label: 'Aplicar filtros', isFullWidth: true, onPress: widget.onFilter),
        ],
      ), 
    );
  }
}
