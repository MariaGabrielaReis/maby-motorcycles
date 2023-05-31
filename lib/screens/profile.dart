
import 'package:flutter/material.dart';
import 'package:flutter_app/models/term.dart';
import 'package:flutter_app/services/graphql_service.dart';
import 'package:flutter_app/ui/button.dart';
import 'package:flutter_app/ui/list_option.dart';
import 'package:flutter_app/ui/switch.dart' as Custom;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override  
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _graphQLService = GraphQLService();
  late Term _term;
  late List<TermOption> _termOptions;
  List<UserPreference> _options = [];
  bool isOptionsLoading = true;
  bool isLoading = false;
  List<String> optionsRejected = [];

  initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    setState(() { isOptionsLoading = true; });
    
    final response = await _graphQLService.getTerm();
    _term = response.term;
    _termOptions = response.options;

    _options = await _graphQLService.getUserPreferences(
      userId: "cli64tx7y5bna0bkdyj8zxz4g", 
      termId: _term.id,
      optionIds: List<String>.from(response.options.map((termOption) => termOption.option.id).toList())
    );
    _options.forEach((option) => {
      if(!option.isAccepted) optionsRejected.add(option.option.id)
    });

    setState(() { isOptionsLoading = false; });
  }

  void _changeTermsAccepted(String id, bool? value) {    
    setState(() { 
      value == true 
        ? optionsRejected.remove(id) 
        : optionsRejected.add(id);
    });
  }

  void _send() {
    setState(() { isLoading = true; });

    _termOptions.forEach((termOption) async => {
      await _graphQLService.acceptTerm(
        isAccepted: !optionsRejected.contains(termOption.option.id), 
        userId: "cli64tx7y5bna0bkdyj8zxz4g", 
        termOptionId: termOption.id,
      )
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: const Text('Preferências atualizadas!'))
    );

    setState(() { isLoading = false; });
  }

  @override
  Widget build(BuildContext context) {
    final fivePercentOfScreen = (MediaQuery.of(context).size.width / 100) * 5;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
        foregroundColor: Colors.teal,
        backgroundColor: Colors.transparent, 
        shadowColor: Colors.transparent, 
        iconTheme: IconThemeData(color: Colors.teal), 
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: fivePercentOfScreen,
          left: fivePercentOfScreen > 64 ? fivePercentOfScreen * 1.5 : fivePercentOfScreen,
          right: fivePercentOfScreen > 64 ? fivePercentOfScreen * 1.5 : fivePercentOfScreen,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0), 
            ListOption(
              label: 'Atualizar dados da conta',
              icon: Icons.mode_edit_outlined,
              onPress: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: const Text('Em breve!'))
              ),
            ),
            const SizedBox(height: 4.0), 
            ListOption(
              label: 'Lista de desejos',
              icon: Icons.favorite_border_rounded,
               onPress: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: const Text('Em breve!'))
              ),
            ),
            const SizedBox(height: 4.0), 
            ListOption(
              label: 'Deletar conta',
              icon: Icons.delete_outline_rounded,
               onPress: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: const Text('Em breve!'))
              ),
            ),
            const SizedBox(height: 16.0), 
            const Divider(),
            const SizedBox(height: 16.0),
            const Text('Minhas preferências:'),
            const SizedBox(height: 8.0), 
             isOptionsLoading 
              ? const Center(child: CircularProgressIndicator()) 
              : ListView.separated(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(), 
                itemCount: _options.length,
                separatorBuilder: (_, int index) => const SizedBox(height: 8.0),
                itemBuilder: (_, int index) {
                  final option = _options[index].option;

                  return Custom.Switch(
                    label: option.title, 
                    description: option.description,
                    isChecked: !optionsRejected.contains(option.id),
                    onPress: (bool? value) => _changeTermsAccepted(option.id, value),
                  );
                },
              ),    
            const SizedBox(height: 16.0), 
            const Divider(),
            const SizedBox(height: 16.0),  
            isLoading 
              ? const Center(child: CircularProgressIndicator()) 
              : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Button(label: 'Editar', onPress: () => _send()),
                  Button(
                    label: 'Cancelar', 
                    onPress: () => Navigator.pop(context), 
                    type: ButtonTypes.unfilled,
                  ),
                ],
              ),                   
          ],
        ),
      ),
    );
  }
}