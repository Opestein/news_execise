import 'dart:async';
import 'dart:io' as io;

import 'package:newsexecise/src/model/headline_response.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._();
  static final DatabaseHelper databaseHelper = DatabaseHelper._();

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  String tableName = 'newsapp';

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "news_app_sqfle.db");
    var theDb = await openDatabase(path,
        version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE newsapp (id INTEGER PRIMARY KEY, title TEXT, content TEXT, publishedAt TEXT, urlToImage TEXT)");
    print("Created table");
  }

  void _onUpgrade(Database db, int version, int newVersion) async {
    // When creating the db, create the table
    if (version < newVersion) {
      await db.execute(
          "ALTER TABLE newsapp (id INTEGER PRIMARY KEY, title TEXT, content TEXT, publishedAt TEXT, urlToImage TEXT)");
      print("Altered table");
    }
  }

  Future<int> saveArticle(Article visitor) async {
//    initDb();
    var dbClient = await db;
    int res = await dbClient.insert(tableName, visitor.toSaveJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  Future<List<Article>> getAllArticles() async {
    var dbClient = await db;
    List<Map<String, dynamic>> res = await dbClient.query(tableName);
    print(res.toString());
    return List.generate(res.length, (i) {
      return Article(
        title: res[i]['title'],
        content: res[i]['content'],
        publishedAt: res[i]['publishedAt'],
        urlToImage: res[i]['urlToImage'],
      );
    });
  }

  Future<int> getAllArticlesLength() async {
    var dbClient = await db;
    List<Map<String, dynamic>> res = await dbClient.query(tableName);
//    TotalGamesPlayed totalGamesPlayed =
//        res.isNotEmpty ? TotalGamesPlayed.map(res) : [];

    List<Article> list = List.generate(res.length, (i) {
      return Article(
        title: res[i]['title'],
        content: res[i]['content'],
        publishedAt: res[i]['publishedAt'],
        urlToImage: res[i]['urlToImage'],
      );
    });

    print(list.length.toString());
    return list.length;
  }

//  Future<int> updateArticlesList(TotalArticles totalArticles) async {
//    var dbClient = await db;
//    int res = await dbClient.update(
//      tableName,
//      totalArticles.toMap(),
//        where: "id = ?", whereArgs: [newClient.id]
//    );
//    return res;
//  }

  Future<void> deleteAllArticles() async {
    var dbClient = await db;
    int res = await dbClient.delete(tableName);
    return res;
  }

  Future<void> deleteArticles(int id) async {
    var dbClient = await db;

    await dbClient.delete(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

//  Future<bool> isLoggedIn() async {
//    var dbClient = await db;
//    var res = await dbClient.query("User");
//    return res.length > 0 ? true : false;
//  }
}
