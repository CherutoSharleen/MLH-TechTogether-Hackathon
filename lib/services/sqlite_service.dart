import 'package:path/path.dart'; //location of file that has the DB
import 'package:sqflite/sqflite.dart'; //library to work with SQLite
import '../models/models.dart';

class SqliteService {
  final String dbName = "saidia.db";

//Connect to Database
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, dbName),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE Contacts(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, phones TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

//insert Contact
  Future<int> insertContact(Contact contact) async {
    final Database db = await initDB();
    return await db.insert(
      'Contacts',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

//get all Contacts
  Future<List<Contact>> getContacts() async {
    final Database db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query('Contacts');
    return List.generate(maps.length, (i) {
      final phonesString = maps[i]['phones'] as String;
      final phonesList = phonesString.split(',');
      final phones = phonesList.map((phone) => phone.trim()).toList();
      return Contact(
        name: maps[i]['name'],
        phones: phones,
      );
    });
  }



//delete Contact
  Future<void> deleteContact(int id) async {
    final db = await initDB();
    await db.delete(
      'Contacts',
      where: "id = ?",
      whereArgs: [id],
    );
  }

//update Contact
  Future<void> updateContact(Contact contact) async {
    final db = await initDB();
    await db.update(
      'Contacts',
      contact.toMap(),
      where: "id = ?",
      // whereArgs: [contact.id],
    );
  }

}
