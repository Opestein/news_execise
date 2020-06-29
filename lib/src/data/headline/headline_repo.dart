import 'package:async/async.dart';
import 'package:dio/dio.dart';

import 'package:newsexecise/src/data/headline/headline_provider.dart';

class _HeadlineRepo {
  CancelableOperation _cancelableOperation;

  cancelOperation() async {
    if (_cancelableOperation != null) await _cancelableOperation.cancel();
  }

  getHeadline(Dio dio) {
    return headlineProvider.getHeadline(
      dio,
    );
  }
}

final headlineRepo = _HeadlineRepo();
