import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:newsexecise/main.dart';
import 'package:newsexecise/src/app.dart';
import 'package:newsexecise/src/data/headline/headline_repo.dart';
import 'package:newsexecise/src/data/sql_database_provider/database_helper_repo.dart';
import 'package:newsexecise/src/model/headline_response.dart';
import 'package:newsexecise/src/utils/operation.dart';
import 'package:rxdart/rxdart.dart';

class HeadlineBloc {
  CancelableOperation _cancelableOperation;
  final BehaviorSubject<HeadlineResponse> _behaviorSubject =
      BehaviorSubject<HeadlineResponse>();

  BehaviorSubject<HeadlineResponse> get behaviorSubject => _behaviorSubject;

  HeadlineBloc();

  fetchCurrent(Dio dio, {Function() performFunc}) async {
    _behaviorSubject.add(null);

    _cancelableOperation = CancelableOperation.fromFuture(headlineRepo
        .getHeadline(
      dio,
    )
        .then((response) async {
      Operation operation = response;
      if (operation.code == 200) {
        HeadlineResponse headlineResponse = operation.result;

        if (performFunc != null) {
          performFunc();
        }
        saveEmployees(
          headlineResponse.articles,
        );

        _behaviorSubject.add(headlineResponse);
      } else {
        dataCheck();
      }
    }));
  }

  dataCheck() async {
    List<Article> list = await offlineCheck();
    if (list != null) {
      if (list.length > 0) {
        list = List<Article>();

        for (int i = 0; i < list.length; i++) {
          list.add(Article(
            urlToImage: list.elementAt(i).urlToImage,
            title: list.elementAt(i).title,
            publishedAt: list.elementAt(i).publishedAt,
            content: list.elementAt(i).content,
          ));
        }

        _behaviorSubject.add(HeadlineResponse(articles: list));
      } else {
        _behaviorSubject.add(null);
      }
    } else {
      _behaviorSubject.add(null);
    }
  }

  Future offlineCheck() async {
    List<Article> list = await databaseArticlesHelperRepo.getAllArticles();

    if (list != null) {
      return list;
    }

    return null;
  }

  saveEmployees(
    List<Article> list,
  ) async {
    await databaseArticlesHelperRepo.deleteAllArticles();
    for (int i = 0; i < list.length; i++) {
      Article article = Article(
        urlToImage: list.elementAt(i).urlToImage,
        title: list.elementAt(i).title,
        publishedAt: list.elementAt(i).publishedAt,
        content: list.elementAt(i).content,
      );
      await databaseArticlesHelperRepo.saveArticle(
        article,
      );
    }
  }

  cancelOperation() async {
    if (_cancelableOperation != null) await _cancelableOperation.cancel();
  }

  dispose() {
    _behaviorSubject.close();
  }
}

final headlineBloc = HeadlineBloc();
