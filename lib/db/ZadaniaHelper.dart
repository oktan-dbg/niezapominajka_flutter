import 'package:niezapominajka_flutter/models/Zadania.dart';
import 'package:sqflite/sqflite.dart';

class ZadaniaHelper{
  static Database? _db;
  static final int _version = 1; 
  static final String _tableName = "zadania";

  static Future<void> initDb() async{
    if(_db != null){
      return;
    }
    try{
      String _path = await getDatabasesPath() + 'zadania.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version){
          print("creating a new one");
          return db.execute(
            "CREATE TABLE $_tableName("
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "dataDodania STRING, nazwa TEXT,"
                "opis STRING, projekt TEXT,"
                "dataDeadline STRING, godzinaDeadline TEXT,"
                "dlugosc INTEGER, priorytet TEXT,"
                "rodzaj TEXT, okresWykonania INTEGER,"
                "wykonane INTEGER)", 
          );
        },
      );
    } catch (e){
      print(e);
    }
  }

  static Future<int> insert(Zadania? zadania) async {
    print("insert function called");
    return await _db?.insert(_tableName, zadania!.toJson())??1;
  }

  static Future<List<Map<String, dynamic>>> query() async{
    print("query function called");
    return _db!.query(_tableName);
  }

  static delete(Zadania zadania) async{
    return await _db!.delete(_tableName, where: 'id=?', whereArgs: [zadania.id]);
  }

  static update(int id) async{
    return await _db!.rawUpdate('''
      UPDATE zadania
      SET wykonane = ?
      WHERE id = ?
    ''', [1, id]);
  }

}