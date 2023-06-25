import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/sqlite_service.dart';

Future<void> showAddContactDialog(BuildContext context) async {
  final nameController = TextEditingController();
  final phoneControllers = List.generate(5, (_) => TextEditingController());

  final sqliteService = SqliteService();

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Add Contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16),
            Text('Phone Numbers:'),
            SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              itemCount: phoneControllers.length,
              itemBuilder: (context, index) {
                return TextField(
                  controller: phoneControllers[index],
                  decoration: InputDecoration(labelText: 'Phone ${index + 1}'),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final name = nameController.text.trim();
              final phones = phoneControllers
                  .map((controller) => controller.text.trim())
                  .where((phone) => phone.isNotEmpty)
                  .toList();

              if (name.isNotEmpty && phones.isNotEmpty) {
                final contact = Contact(name: name, phones: phones);
                try {
                  final id = sqliteService.insertContact(contact);

                  print('Contact added with id: $id');
                  Navigator.of(context).pop();
                } catch (e) {
                  print('Error: $e');
                }
              }
            },
            child: Text('Add'),
          ),
        ],
      );
    },
  );
}
