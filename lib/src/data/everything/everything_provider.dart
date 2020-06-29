import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:newsexecise/src/app.dart';
import 'package:newsexecise/src/data/base_url.dart';
import 'package:newsexecise/src/model/error.dart';
import 'package:newsexecise/src/model/headline_response.dart';
import 'package:newsexecise/src/utils/operation.dart';

class EverythingProvider {
  Future<Operation> getEverything(
    Dio dio,
  ) async {
    var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime currentTime = DateTime.now();
    String from = formatter
        .format(currentTime.subtract(Duration(days: 4)))
        .replaceAll(' ', 'T');
    String to = formatter.format(currentTime).replaceAll(' ', 'T');

    print(from);
    print(to);

    final url =
        baseUrlV1 + 'everything?q=apple&from=$from&to=$to&sortBy=popularity';

    var response = await dio
        .get(
      url,
      options: Options(
          responseType: ResponseType.json,
          followRedirects: false,
          headers: {'X-Api-Key': kApiKey},
          validateStatus: (status) {
            return status < 500;
          }),
    )
        .timeout(Duration(minutes: 10), onTimeout: () async {
      return Response(
          data: {"message": "Connection Timed out. Please try again"},
          statusCode: 408);
    }).catchError((error) {
      return Response(
          data: {"message": "Error occurred while connecting to server"},
          statusCode: 508);
    });

    if (response.statusCode == 200) {
      final responseJson = response.data;

      var data = HeadlineResponse.fromJson(responseJson);

      return Operation(response.statusCode, data);
    } else {
      var error = ErrorResponse.fromJson(response.data);
      return Operation(response.statusCode, error);
    }
  }
}

final everythingProvider = EverythingProvider();
