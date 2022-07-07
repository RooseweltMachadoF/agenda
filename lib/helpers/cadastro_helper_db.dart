import 'package:agenda_btg/app/cadastro/models/person_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class CadastroHelper {
  // static final CadastroHelper instance = CadastroHelper();

  // CadastroHelper();
  static final CadastroHelper _instance = CadastroHelper.internal();

  factory CadastroHelper() => _instance;

  CadastroHelper.internal();

  late Database _database;

  final String contactTable = "contactTable";
  final String idColumn = "idColumn";
  final String nameColumn = "nameColumn";
  final String phoneColumn = "phoneColumn";
  final String imgColumn = "imgColumn";
  final String cpfColumn = 'cpfColumn';
  final String nascColumn = 'nascColumn';
  final String themeIsDark = 'themeIsDarkColumn';

  Future<Database> initDb() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "contacts.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          "CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT,"
          "$phoneColumn TEXT, $imgColumn TEXT, $cpfColumn INTEGER, $nascColumn INTEGER, $themeIsDark INTEGER)");
    });
  }

  Future<PersonModel> saveContact(PersonModel contact) async {
    Database dbContact = await initDb();
    await dbContact.insert(contactTable, contact.toMap());
    await dbContact.close();
    return contact;
  }

  Future<List<PersonModel>> getAllContacts() async {
    Database dbContact = await initDb();
    List listMap = await dbContact.rawQuery("SELECT * FROM $contactTable");
    List<PersonModel> listContact = [];
    for (Map<String, dynamic> m in listMap) {
      listContact.add(PersonModel.fromMap(m));
    }
    await dbContact.close();
    return listContact;
  }

  Future<int> updateContact(PersonModel contact) async {
    Database dbContact = await initDb();
    int i = await dbContact.update(contactTable, contact.toMap(),
        where: "$idColumn = ?", whereArgs: [contact.id]);
    await dbContact.close();
    return i;
  }

  Future<int> deleteContact(int id) async {
    Database dbContact = await initDb();
    int i = await dbContact
        .delete(contactTable, where: "$idColumn = ?", whereArgs: [id]);
    await dbContact.close();
    return i;
  }
}
