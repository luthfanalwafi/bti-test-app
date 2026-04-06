import 'package:bti_test_app/models/news.dart';
import 'package:bti_test_app/services/sqflite/index.dart';
import 'package:bti_test_app/services/sqflite/table_name.dart';
import 'package:sqflite/sqflite.dart';

class BookmarkDB {
  final tableName = tableBookmark;

  BookmarkDB() {
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

  Future<List<NewsModel>> getNews() async {
    try {
      final service = SQFLiteService();
      final db = await service.database;

      final response = await db.query(tableName);
      final result = response.map((e) => NewsModel.fromDb(e)).toList();

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> insert(NewsModel news) async {
    try {
      final service = SQFLiteService();
      final db = await service.database;

      await delete(news.title);

      final batch = db.batch();
      final data = news.toJson();

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

  Future<void> delete(String? title) async {
    try {
      final service = SQFLiteService();
      final db = await service.database;
      if (title != null) {
        await db.delete(tableName, where: 'title = ?', whereArgs: [title]);
      }
    } catch (e) {
      rethrow;
    }
  }
}
