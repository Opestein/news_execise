import 'package:newsexecise/src/data/sql_database_provider/database_helper.dart';
import 'package:newsexecise/src/model/headline_response.dart';

class DatabaseArticlesHelperRepo {
  Future<int> saveArticle(Article article) async {
    print("hhhhpp");
    return await DatabaseHelper.databaseHelper.saveArticle(article);
  }
//  Future<List<Articles>> getArticles() async =>
//      DatabaseHelper.databaseHelper.gev();

  Future<List<Article>> getAllArticles() async =>
      DatabaseHelper.databaseHelper.getAllArticles();

  Future<int> getAllArticlesLength() async =>
      DatabaseHelper.databaseHelper.getAllArticlesLength();

  Future<void> deleteAllArticles() async =>
      DatabaseHelper.databaseHelper.deleteAllArticles();

  Future<void> deleteArticles(int id) async =>
      DatabaseHelper.databaseHelper.deleteArticles(id);
}

final databaseArticlesHelperRepo = DatabaseArticlesHelperRepo();
