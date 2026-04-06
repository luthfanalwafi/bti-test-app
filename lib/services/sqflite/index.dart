import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SQFLiteService {
  static final SQFLiteService _instance = SQFLiteService.internal();

  final databaseName = 'bti_test.db';
  final databaseVersion = 1;

  factory SQFLiteService() => _instance;
  static Database? _database;

  Future<Database> get database async {
    return _database ?? await initDatabase();
  }

  SQFLiteService.internal();

  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, databaseName);
    final database = await openDatabase(path, version: databaseVersion);
    return database;
  }

  Future<void> close() async {
    final Database dbClient = await database;
    _database = null;
    return dbClient.close();
  }
}
