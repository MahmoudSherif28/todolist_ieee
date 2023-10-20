import 'package:sqflite/sqflite.dart';
import 'package:todolist/database/database_connextion.dart';

class Repository {
  DatabaseConnection? _databaseConnection;

  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection!.setdatabase();
    return _database;
  }

  insertdata(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }
  readdata(table)async{
    var connection=await database;
    return await connection?.query(table);
  }
  readDataById(table,itemId)async{
    var connection=await database;
  return await connection?.query(table,where: 'id=?',whereArgs: [itemId]);


  }
  updatedata(table,data)async{
    var connection=await database;
 return await connection?.update(table, data,where:'id=?',whereArgs: [data['id']]);

  }

}
