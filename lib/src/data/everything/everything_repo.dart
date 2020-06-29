import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:newsexecise/src/data/everything/everything_provider.dart';
import 'package:newsexecise/src/data/headline/headline_provider.dart';

class _EverythingRepo {
  CancelableOperation _cancelableOperation;

  cancelOperation() async {
    if (_cancelableOperation != null) await _cancelableOperation.cancel();
  }

  getEverything(
    Dio dio,
  ) {
    return everythingProvider.getEverything(
      dio,
    );
  }
}

final everythingRepo = _EverythingRepo();
