
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/button.dart';
import 'package:flutter_app/ui/input.dart';
import 'package:flutter_app/utils/validate_input.dart';

class SignIn extends StatefulWidget {
  @override  
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  static var name = '', email = '', address = '';
  static var number = '', complement = '', uf = '', cep = '';
  static final validator = InputValidator();

  final inputs = [
    Input(
      label: 'Nome',
      icon: const Icon(Icons.account_circle_outlined),
      validator: validator.validateText,
      onSaved: (String value) {
        name = value;
      }, 
    ),
    Input(
      label: 'E-mail',
      icon: const Icon(Icons.email_outlined),
      validator: validator.validateText,
      onSaved: (String value) {
        email = value;
      },
    ),
    Input(
      label: 'Endereço',
      icon: const Icon(Icons.house_outlined),
      validator: validator.validateText,
      onSaved: (String value) {
        address = value;
      },
    ),
    Input(
      label: 'Número',
      icon: const Icon(Icons.numbers_outlined),
      keyboardType: TextInputType.number,
      validator: validator.validateText,
      onSaved: (String value) {
        number = value;
      },
    ),
    Input(
      label: 'Complemento',
      icon: const Icon(Icons.control_point_outlined),
      validator: validator.validateText,
      onSaved: (String value) {
        complement = value;
      },
    ),
    Input(
      label: 'UF',
      icon: const Icon(Icons.emoji_flags_outlined),
      validator: validator.validateText,
      onSaved: (String value) {
        uf = value;
      },
    ),
    Input(
      label: 'CEP',
      icon: const Icon(Icons.other_houses_outlined),
      validator: validator.validateText,
      onSaved: (String value) {
        cep = value;
      },
    ),
  ];

  void _sendForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger
        .of(context)
        .showSnackBar(SnackBar(content: Text('Dados enviados com sucesso!')));
    } 
  }

  @override
  Widget build(BuildContext context) {
    final tenPercentOfScreen = (MediaQuery.of(context).size.width / 100) * 10;

    return Scaffold(
      appBar: AppBar(title: const Text('Formulário de cadastro')),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: tenPercentOfScreen/2,
          horizontal: tenPercentOfScreen > 64 ? tenPercentOfScreen * 1.5 : tenPercentOfScreen,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                ' Crie sua conta!',
                style: TextStyle(fontSize: 18.0, color: Colors.teal),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: MediaQuery.of(context).size.height/2,
                child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: inputs.length,
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8.0),
                    itemBuilder: (BuildContext context, int index) {
                      return inputs[index];
                    },
                  ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Button(label: 'Enviar', onPress: () => _sendForm()),
                  Button(
                    label: 'Cancelar', 
                    onPress: () => _formKey.currentState!.reset(), 
                    type: ButtonTypes.unfilled,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}