import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path/path.dart';
import "package:path_provider/path_provider.dart";

class DatabaseConnection {
  setdatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, "db_todolist_sqflite");
    var database =
        await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database database, int version) async {
    await database.execute('''CREATE TABLES categories(
        id INTEGER PRIMARY KEY,
        task TEXT,
        date TEXT
        )''');
    await database.execute('''CREATE TABLES todo(
      id INTEGER PRIMARY KEY,
      title TEXT,
      description TEXT,
      category TEXT,
      todoDate TEXT,
      isFinished INTEGER,
      ''');
  }
}
