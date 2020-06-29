import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:newsexecise/src/app.dart';
import 'package:newsexecise/src/data/everything/everything_repo.dart';
import 'package:newsexecise/src/data/headline/headline_repo.dart';
import 'package:newsexecise/src/model/headline_response.dart';
import 'package:newsexecise/src/utils/operation.dart';
import 'package:rxdart/rxdart.dart';

class EverythingNewsBloc {
  CancelableOperation _cancelableOperation;
  final BehaviorSubject<HeadlineResponse> _behaviorSubject =
      BehaviorSubject<HeadlineResponse>();

  BehaviorSubject<HeadlineResponse> get behaviorSubject => _behaviorSubject;

  EverythingNewsBloc();

  fetchCurrent(Dio dio) async {
    _cancelableOperation = CancelableOperation.fromFuture(everythingRepo
        .getEverything(
      dio,
    )
        .then((response) async {
      Operation operation = response;
      if (operation.code == 200) {
        HeadlineResponse headlineResponse = operation.result;
        _behaviorSubject.add(headlineResponse);
      } else {
        _behaviorSubject.addError(operation.result);
      }
    }));
  }

  cancelOperation() async {
    if (_cancelableOperation != null) await _cancelableOperation.cancel();
  }

  dispose() {
    _behaviorSubject.close();
  }
}

final everythingNewsBloc = EverythingNewsBloc();
