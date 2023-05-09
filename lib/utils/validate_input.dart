import 'package:flutter_app/ui/input.dart';

class InputValidator {
  String? validateText(String value, {InputType? type = InputType.text}) {
    switch(type) {
      case InputType.email:
        String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regExp = new RegExp(pattern);
        if (value.length == 0) return "Campo obrigatório";
        if(!regExp.hasMatch(value)) return "Email inválido";
        return null;

      case InputType.password:
        if (value.length == 0) return "Campo obrigatório";
        if (value.length < 5) return "Mínimo de 6 caracteres";
        return null;

      case InputType.number:
        String patttern = r'(^[0-9]*$)';
        RegExp regExp = new RegExp(patttern);
        if (value.length == 0) return "Campo obrigatório";
        if (!regExp.hasMatch(value)) return "Deve conter apenas números";
        return null;

      case InputType.CEP:
        String patttern = r'(^[0-9]*$)';
        RegExp regExp = new RegExp(patttern);
        if (value.length == 0) return "Campo obrigatório";
        if (value.length != 8) return "Deve conter 8 dígitos";
        if (!regExp.hasMatch(value)) return "Deve conter apenas números";
        return null;

      case InputType.UF:
        if (value.length == 0) return "Campo obrigatório";
        if (value.length != 2) return "Deve conter 2 letras";
        return null;

      case InputType.text:
        if (value.length == 0) return "Campo obrigatório";
        return null;

      case InputType.optional:
        return null;

      default:
        return null;
    }
  }
}
