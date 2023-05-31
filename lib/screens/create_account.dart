
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/service_terms.dart';
import 'package:flutter_app/ui/button.dart';
import 'package:flutter_app/ui/input.dart';
import 'package:flutter_app/utils/validate_input.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override  
  State<StatefulWidget> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  static var name = '', email = '', address = '', password = '';
  static var number = '', complement = '', uf = '', cep = '';
  static final validator = InputValidator();

  final inputs = [
    Input(
      label: 'Nome',
      placeholder: 'Digite seu nome',
      icon: const Icon(Icons.account_circle_outlined),
      validator: validator.validateText,
      onSaved: (String value) => name = value,
    ),
    Input(
      label: 'E-mail',
      placeholder: 'Digite seu e-mail',
      inputType: InputType.email,
      icon: const Icon(Icons.email_outlined),
      validator: validator.validateText,
      onSaved: (String value) => email = value,
    ),
    Input(
      label: 'Senha',
      placeholder: 'Digite sua senha',
      inputType: InputType.password,
      icon: const Icon(Icons.lock_outline),
      validator: validator.validateText,
      onSaved: (String value) => password = value,
    ),
    Input(
      label: 'Endereço',
      placeholder: 'Digite seu endereço',
      icon: const Icon(Icons.house_outlined),
      validator: validator.validateText,
      onSaved: (String value) => address = value,
    ),
    Input(
      label: 'Número',
      placeholder: 'Digite o número',
      inputType: InputType.number,
      icon: const Icon(Icons.numbers_outlined),
      validator: validator.validateText,
      onSaved: (String value) => number = value,
    ),
    Input(
      label: 'Complemento',
      placeholder: 'Digite seu complemento',
      inputType: InputType.optional,
      icon: const Icon(Icons.control_point_outlined),
      validator: validator.validateText,
      onSaved: (String value) => complement = value,
    ),
    Input(
      label: 'UF',
      placeholder: 'Digite sua UF',
      inputType: InputType.UF,
      icon: const Icon(Icons.emoji_flags_outlined),
      validator: validator.validateText,
      onSaved: (String value) => uf = value,
    ),
    Input(
      label: 'CEP',
      placeholder: 'Digite seu CEP',
      inputType: InputType.CEP,
      icon: const Icon(Icons.other_houses_outlined),
      validator: validator.validateText,
      onSaved: (String value) => cep = value,
    ),
  ];

  void _sendForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => ServiceTerms()),
      );
    } 
  }

  @override
  Widget build(BuildContext context) {
    final tenPercentOfScreen = (MediaQuery.of(context).size.width / 100) * 10;

    return Scaffold(
      appBar: AppBar(title: const Text('Formulário de cadastro')),
      body: SingleChildScrollView(
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
              ListView.separated(
                shrinkWrap: true,
                itemCount: inputs.length,
                separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8.0),
                itemBuilder: (BuildContext context, int index) {
                  return inputs[index];
                },
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}