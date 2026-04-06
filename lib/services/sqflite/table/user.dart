import 'package:bti_test_app/models/user.dart';
import 'package:bti_test_app/services/sqflite/index.dart';
import 'package:bti_test_app/services/sqflite/table_name.dart';
import 'package:sqflite/sqflite.dart';

class UserDB {
  final tableName = tableUser;

  UserDB() {
    create();
  }

  void create() async {
    try {
      final service = SQFLiteService();
      final Database db = await service.database;

      await db.execute("""
        CREATE TABLE IF NOT EXISTS $tableName(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          email TEXT
        )
      """);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> getUser() async {
    try {
      final service = SQFLiteService();
      final db = await service.database;

      final response = await db.query(tableName, limit: 1);
      if (response.isEmpty) return null;
      final result = UserModel.fromDb(response.first);

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> insert(UserModel user) async {
    try {
      final service = SQFLiteService();
      final db = await service.database;

      final batch = db.batch();
      final data = user.toJson();

      batch.insert(
        tableName,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      await batch.commit(noResult: true);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete() async {
    try {
      final service = SQFLiteService();
      final db = await service.database;

      await db.delete(tableName);
    } catch (e) {
      rethrow;
    }
  }
}
