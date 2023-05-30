class Option {
  final String id;
  final String title;
  final String description;

  const Option({ 
    required this.id,
    required this.title, 
    required this.description, 
  });

  static Option fromMap(Map item) => Option(
    id: item['id'],
    title: item['title'],
    description: item['description'],
  );
}

class TermOption {
  final String id;
  final Option option;

  TermOption({ 
    required this.id,
    required this.option, 
  });

  static TermOption fromMap(Map item) => TermOption(
    id: item['id'],
    option: Option.fromMap(item['option']),
  );
}

class Term {
  final String id;
  final DateTime date;
  final double version;
  final String description;


  Term({ 
    required this.id,
    required this.date,
    required this.version, 
    required this.description, 
  });

  static Term fromMap(Map item) => Term(
    id: item['id'],
    date: DateTime.parse(item['createdAt']),
    version: (item['version']).toDouble(),
    description: item['description'],
  );
}

class UserPreference {
  final bool isAccepted;
  final Option option;

  const UserPreference({ 
    required this.isAccepted,
    required this.option, 
  });

  static UserPreference fromMap(Map item) => UserPreference(
    isAccepted: item['accepted'],
    option: Option.fromMap(item['termOption']['option']),
  );
}
