import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/services/graphql_service.dart';
import 'package:flutter_app/models/term.dart';
import 'package:flutter_app/ui/button.dart';
import 'package:flutter_app/ui/switch.dart' as Custom;

final _graphQLService = GraphQLService();

class ServiceTerms extends StatefulWidget {
  const ServiceTerms({super.key});

  @override  
  State<StatefulWidget> createState() => _ServiceTermsState();
}

class _ServiceTermsState extends State<ServiceTerms> {
  bool isLoading = true;
  Term? _term;
  List<TermOption>? _options;

  initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final response = await _graphQLService.getTerm();
    _term = response.term;
    _options = response.options;
    setState(() { isLoading = false; });
  }

  @override
  Widget build(BuildContext context) {
    final tenPercentOfScreen = (MediaQuery.of(context).size.width / 100) * 10;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Termos de Uso'),
        foregroundColor: Colors.teal,
        backgroundColor: Colors.transparent, 
        shadowColor: Colors.transparent, 
        iconTheme: IconThemeData(color: Colors.teal),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: tenPercentOfScreen/2,
          horizontal: tenPercentOfScreen > 64 ? tenPercentOfScreen * 1.5 : tenPercentOfScreen,
        ),
        child: isLoading
          ? const Center(child: CircularProgressIndicator()) 
          : TermForm(term: _term!, options: _options!),
      ),
    );
  }
}

class TermForm extends StatefulWidget {
  final Term term;
  final List<TermOption> options;

  const TermForm({ Key? key,  required this.term, required this.options }) : super(key: key);

  @override  
  State<StatefulWidget> createState() => _TermFormState();
}

class _TermFormState extends State<TermForm> {
  List<String> optionsRejected = [];
  bool isLoading = false;
  late Term term = widget.term;
  late List<TermOption> termOptions = widget.options;

  void _rejectTerm(String id, bool? value) {
    setState(() { 
      value == true 
        ? optionsRejected.remove(id) 
        : optionsRejected.add(id);
    });
  }

  void _send() {
    setState(() { isLoading = true; });
    termOptions.forEach((termOption) async => {
      await _graphQLService.acceptTerm(
        isAccepted: !optionsRejected.contains(termOption.option.id), 
        userId: "cli64tx7y5bna0bkdyj8zxz4g", 
        termOptionId: termOption.id,
      )
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: const Text('Preferências salvas!'))
    );
        
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(term.date);
  
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Versão: ${term.version} (${formattedDate})', style: TextStyle(fontSize: 12.0, color: Colors.grey)),
        const SizedBox(height: 16.0),
        Text(term.description),
        const SizedBox(height: 16.0), 
        const Divider(),
        const SizedBox(height: 16.0),
        const Text('Selecione abaixo as permissões que deseja conceder em relação aos dados cedidos:'),
        const SizedBox(height: 8.0), 
        ListView.separated(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(), 
          itemCount: termOptions.length,
          separatorBuilder: (_, int index) => const SizedBox(height: 8.0),
          itemBuilder: (_, int index) {
            final option = termOptions[index].option;

            return Custom.Switch(
              label: option.title, 
              description: option.description,
              isChecked: !optionsRejected.contains(option.id),
              onPress: (bool? value) => _rejectTerm(option.id, value),
            );
          },
        ),    
        const SizedBox(height: 16.0), 
        const Divider(),
        const SizedBox(height: 16.0),  
        isLoading 
          ? const Center(child: CircularProgressIndicator()) :
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Button(label: 'Enviar', onPress: () => _send()),
              Button(
                label: 'Voltar', 
                onPress: () => Navigator.pop(context), 
                type: ButtonTypes.unfilled,
              ),
            ],
          ),    
      ],
    );
  }
}