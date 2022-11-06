import 'package:roomrai1/models/task.dart';
import 'package:flutter/rendering.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _dBase;
  static final int _version = 1;
  static final String _tableName = "dkoo";

  static Future<void> initDb() async {
    if (_dBase != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'dkoo.db';
      _dBase =
          await openDatabase(_path, version: _version, onCreate: (db, version) {
        print("creating a new one");
        return db.execute(
          "CREATE TABLE $_tableName("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "codeRoom STRING, floor INTEGER, room INTEGER, "
          "building STRING, showSearch STRING)",
        );
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Task? task) async {
    print("int function called");
    return await _dBase?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("query function called");
    return await _dBase!.query(_tableName);
  }

  static delete(Task task) async {
    return await _dBase!
        .delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }
}
// db.execute(
//           "CREATE TABLE $_tableName("
//           "id INTEGER PRIMARY KEY AUTOINCREMENT, "
//           "code_room STRING, floor INTEGER, room INTEGER, "
//           "building STRING, showSearch STRING, )",
//         );
