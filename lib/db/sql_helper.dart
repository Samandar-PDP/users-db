import 'package:registation_db/model/user.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sql.dart';

class SqlHelper {
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""
        CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          image TEXT NOT NULL,
          full_name TEXT NOT NULL,
          number TEXT NOT NULL,
          country TEXT NOT NULL,
          address TEXT NOT NULL,
          password TEXT NOT NULL
        )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('users.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTable(database);
    });
  }

  static Future<void> saveUser(User user) async {
    final db = await SqlHelper.db();
    db.insert('users', user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  static Future<List<User>> getUsers() async {
    final db = await SqlHelper.db();
    final map = await db.query('users', orderBy: 'id');
    final List<User> userList = [];
    for (var json in map) {
      userList.add(User.fromJson(json));
    }
    return userList;
  }
  static Future<void> deleteUser(int? id) async {
    final db = await SqlHelper.db();
    await db.delete('users',where: 'id = ?', whereArgs: ['$id']);
  }
}
