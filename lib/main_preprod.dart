import 'package:background_fetch/background_fetch.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:newsexecise/main.dart';
import 'package:newsexecise/src/app.dart';
import 'package:newsexecise/src/home.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dio = Dio();

  var configuredApp = NewsExerciseApp(
    dio: dio,
    child: ActiveEdgeHome(),
    url: "https://newsapi.org/v2/",
    apiKey: '5a8ea2df1bb942ab905c1a54d8747cf9',
  );

  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(configuredApp));

  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}
