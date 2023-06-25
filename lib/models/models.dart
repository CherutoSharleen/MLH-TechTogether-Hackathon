class Contact {
  final String name;
  final List<String> phones;

  Contact({required this.name, required this.phones});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phones': phones
          .join(','), // Convert the list of phones to a comma-separated string
    };
  }

  static Contact fromMap(Map<String, dynamic> map) {
    return Contact(
      name: map['name'],
      phones:
          map['phones'].split(','), // Split the string of phones into a list
    );
  }
}
