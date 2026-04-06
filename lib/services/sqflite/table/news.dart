import 'package:bti_test_app/models/news.dart';
import 'package:bti_test_app/services/sqflite/index.dart';
import 'package:bti_test_app/services/sqflite/table_name.dart';
import 'package:sqflite/sqflite.dart';

class NewsDB {
  final tableName = tableNews;

  NewsDB() {
    create();
  }

  void create() async {
    try {
      final service = SQFLiteService();
      final Database db = await service.database;

      await db.execute("""
        CREATE TABLE IF NOT EXISTS $tableName(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          sourceId TEXT,
          sourceName TEXT,
          author TEXT,
          title TEXT,
          description TEXT,
          url TEXT,
          urlImage TEXT,
          date TEXT,
          content TEXT,
          category TEXT
        )
      """);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NewsModel>> getNewsByCategory(String category) async {
    try {
      final service = SQFLiteService();
      final db = await service.database;

      final response = await db.query(
        tableName,
        where: 'category = ?',
        whereArgs: [category],
      );
      final result = response.map((e) => NewsModel.fromDb(e)).toList();

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> insert(String category, List<NewsModel> news) async {
    try {
      final service = SQFLiteService();
      final db = await service.database;

      await deleteDuplicate(category, db);

      final batch = db.batch();

      for (var item in news) {
        final data = item.toJson();

        batch.insert(
          tableName,
          data,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      await batch.commit(noResult: true);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteDuplicate(String category, Database db) async {
    try {
      await db.delete(tableName, where: 'category = ?', whereArgs: [category]);
    } catch (e) {
      rethrow;
    }
  }
}
