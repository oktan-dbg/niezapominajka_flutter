import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper{
  static Future<void> createTables(sql.Database database) async{
    await database.execute("""CREATE TABLE items(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      data_dodania TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      nazwa TEXT,
      opis TEXT,
      projekt TEXT,
      deadline_data TEXT,
      deadline_godzina TEXT,
      dlugosc INT,
      priorytet TEXT,
      rodzaj TEXT,
      okres_wykonania TEXT,
      wykonane TEXT
    )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'zadania.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        print('...creating a database...');
        await createTables(database);
      }
    );
  }

  static Future<int> createItem(String nazwa, String? opis, String? projekt, String? deadline_data, String? deadline_godzina, int dlugosc, String? priorytet, String? rodzaj, String? okres_wykonania, String? wykonane) async {
    final db = await SQLHelper.db();

    final data = {
      'data_dodania' : DateTime.now().toString(),
      'nazwa' : nazwa,
      'opis' : opis,
      'projekt' : projekt,
      'deadline_data' : deadline_data,
      'deadline_godzina' : deadline_godzina,
      'dlugosc' : dlugosc,
      'priorytet' : priorytet,
      'rodzaj' : rodzaj,
      'okres_wykonania' : okres_wykonania,
      'wykonane' : wykonane
    };
    final id = await db.insert('items', data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async{
    final db = await SQLHelper.db();
    return db.query('items', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async{
    final db = await SQLHelper.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(
      int id, String nazwa, String? opis, String? projekt, String? deadline_data, String? deadline_godzina, int dlugosc, String? priorytet, String? rodzaj, String? okres_wykonania, String? wykonane) async {
    final db = await SQLHelper.db();

    final data = {
      'data_dodania' : DateTime.now().toString(),
      'nazwa' : nazwa,
      'opis' : opis,
      'projekt' : projekt,
      'deadline_data' : deadline_data,
      'deadline_godzina' : deadline_godzina,
      'dlugosc' : dlugosc,
      'priorytet' : priorytet,
      'rodzaj' : rodzaj,
      'okres_wykonania' : okres_wykonania,
      'wykonane' : wykonane
    };

    final result = 
    await db.update('items', data, where: "id = ?", whereArgs: [id]);    
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try{
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    }catch (err){
      debugPrint("Something went wrong when deleting an item $err");
    }
  }
  
}