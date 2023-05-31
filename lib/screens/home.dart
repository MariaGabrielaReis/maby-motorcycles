
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/profile.dart';
import 'package:flutter_app/ui/button.dart';
import 'package:flutter_app/ui/filters_modal.dart';
import 'package:flutter_app/ui/product_card.dart';
import 'package:flutter_app/mocks/motorcycles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override  
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final filters = ['Capacetes', 'Luvas', 'Motos', 'Macacão', 'Acessórios customizados'];
  List<String> selectedFilters = [];
  String filtersMessage = '';

  void _addFilter(String filter) {
    final filterIndex = selectedFilters.indexOf(filter);
    filterIndex > -1
      ? selectedFilters.remove(filter)
      : selectedFilters.add(filter);
  }

  void _applyFilters() {
    if(selectedFilters.length > 0) {
      filtersMessage = selectedFilters.first;
      selectedFilters.forEach((filter) => 
       setState(() {
        filtersMessage += filter != selectedFilters.first ? ' | $filter' : '';
       })
      );
    } else {
      setState(() {
        filtersMessage = '';
      });
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final fivePercentOfScreen = (MediaQuery.of(context).size.width / 100) * 5;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          'images/logo.png',
          height: 36.0,
          fit: BoxFit.fitHeight,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: fivePercentOfScreen,
          horizontal: fivePercentOfScreen > 64 ? fivePercentOfScreen * 1.5 : fivePercentOfScreen,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bem vindo(a)!',
                  style: const TextStyle(fontSize: 18.0, color: Colors.teal),
                ),
                SizedBox(
                  width: 36.0,
                  height: 36.0,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => Profile(), 
                        maintainState: false,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(3.5),
                      shape: CircleBorder(),
                      side: const BorderSide(color: Colors.teal, width: 1.5),
                    ),
                    child: CircleAvatar(
                          backgroundColor: Colors.teal.shade400,
                          child: const Icon(Icons.person, color: Colors.white, size: 24.0),
                        ),
                      ),
              
                ),
              ],
            ),           
            const SizedBox(height: 8.0),
            Button(
              label: 'Filtros', 
              type: ButtonTypes.withIcon,
              onPress: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const CircleBorder(),
                builder: (_) => FiltersModal(
                  filters: filters,
                  selectedFilters: selectedFilters,
                  onSelectFilter: _addFilter, 
                  onFilter: _applyFilters,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            filtersMessage != '' ? Text('Filtrando por: $filtersMessage', style: TextStyle(color: Colors.grey)) : SizedBox.shrink(),
            const SizedBox(height: 16.0),
            ListView.separated(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(), 
              itemCount: motorcycles.length,
              separatorBuilder: (_, int index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: const Divider(),
              ),
              itemBuilder: (_, int index) {
                return ProductCard(motorcycle: motorcycles[index]);
              },
            ),                 
          ],
        ),
      ),
    );
  }
}