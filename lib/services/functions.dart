import 'package:saidia_app/services/sqlite_service.dart';
import '../models/models.dart';

final SqliteService sqliteService = SqliteService();
void addContact() async {
  final newContact = Contact(
    name: 'Kenya Red Cross',
    phones: ['0700 395 395', '0732 129 999'],
  );
  try {
    final id = await sqliteService.insertContact(newContact);
    print('Contact added with id: $id');
  } catch (e) {
    print('Error: $e');
  }
}

void retrieveContacts() async {
  try {
    final contacts = await sqliteService.getContacts();
    for (var contact in contacts) {
      print('Contact: ${contact.name}');
      print('Phones: ${contact.phones}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
