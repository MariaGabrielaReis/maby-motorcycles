class InputValidator {
  String? validateText(String value, String field) {
    if(field == 'Complemento') return null;
    
    if(field != 'E-mail') {
      if (value.length == 0) {
        return "Informe o $field";
      }
      return null;
    } 
    
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Informe o e-mail";
    } else if(!regExp.hasMatch(value)){
      return "Email inválido";
    } else {
      return null;
    } 
  }
}



