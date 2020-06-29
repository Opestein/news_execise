import 'package:dio/dio.dart';
import 'package:newsexecise/src/app.dart';
import 'package:flutter/material.dart';

Type _getType<B>() => B;

class AppConfig<B> extends InheritedWidget {
  final B bloc;
  final String replacementUrlA;
  final Dio dio;
  final NewsExerciseAppState newsExerciseAppState;

  const AppConfig({
    Key key,
    this.bloc,
    this.replacementUrlA,
    this.dio,
    this.newsExerciseAppState,
    Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(AppConfig<B> oldWidget) {
    return true;
//    return oldWidget.bloc != bloc;
  }

  static B of<B>(BuildContext context) {
    final type = _getType<AppConfig<B>>();
    final AppConfig<B> provider = context.inheritFromWidgetOfExactType(type);

    return provider.bloc;
  }
}
