import 'package:bti_test_app/models/chat.dart';
import 'package:bti_test_app/services/sqflite/index.dart';
import 'package:bti_test_app/services/sqflite/table_name.dart';
import 'package:sqflite/sqflite.dart';

class SupportChatDB {
  final tableName = tableChat;

  SupportChatDB() {
    create();
  }

  void create() async {
    try {
      final service = SQFLiteService();
      final Database db = await service.database;

      await db.execute("""
        CREATE TABLE IF NOT EXISTS $tableName(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          newsTitle TEXT,
          text TEXT,
          imagePath TEXT,
          time TEXT,
          isUser INTEGER
        )
      """);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ChatModel>> getChatHistory(String newsTitle) async {
    try {
      final service = SQFLiteService();
      final db = await service.database;

      final response = await db.query(
        tableName,
        where: 'newsTitle = ?',
        whereArgs: [newsTitle],
      );
      final result = response.map((e) => ChatModel.fromDb(e)).toList();

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> insert(String newsTitle, List<ChatModel> chats) async {
    try {
      final service = SQFLiteService();
      final db = await service.database;

      await deleteDuplicate(newsTitle, db);

      final batch = db.batch();

      for (var item in chats) {
        final data = item.toJson();
        data['newsTitle'] = newsTitle;

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

  Future<void> deleteDuplicate(String newsTitle, Database db) async {
    try {
      await db.delete(
        tableName,
        where: 'newsTitle = ?',
        whereArgs: [newsTitle],
      );
    } catch (e) {
      rethrow;
    }
  }
}
