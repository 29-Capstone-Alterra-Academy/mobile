import 'dart:developer';

import 'package:capstone_project/model/search_model/search_history_model.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _userDatabaseHelper;
  static late Database _database;

  DatabaseHelper._internal() {
    _userDatabaseHelper = this;
  }

  factory DatabaseHelper() {
    return _userDatabaseHelper ?? DatabaseHelper._internal();
  }

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  final String _historyTable = 'history';

  Future<Database> _initializeDb() async {
    var db = openDatabase(
      join(await getDatabasesPath(), 'nomizo_db.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_historyTable(
            id INTEGER PRIMARY KEY,
            keyword TEXT
          )
          ''',
        );
      },
      version: 1,
    );
    return db;
  }

  /// INSERT NEW SEARCH HISTORY
  Future<void> insertHistory(SearchHistoryModel history) async {
    try {
      final Database db = await database;
      await db.insert(_historyTable, history.toMap());
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  /// GET SEARCH HISTORY
  Future<List<SearchHistoryModel>> getHistory() async {
    try {
      final Database db = await database;
      var response = await db.query(_historyTable);

      List<SearchHistoryModel> history =
          response.map((e) => SearchHistoryModel.fromMap(e)).toList();

      return history;
    } on Exception catch (e) {
      log(e.toString());
      return <SearchHistoryModel>[];
    }
  }

  /// DELETE SEARCH HISTORY
  Future<void> deleteHistory(int id) async {
    try {
      final db = await database;
      await db.delete(
        _historyTable,
        where: 'id = ?',
        whereArgs: [id],
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }

}
