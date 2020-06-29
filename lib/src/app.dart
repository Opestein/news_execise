import 'package:background_fetch/background_fetch.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:newsexecise/main.dart';
import 'package:newsexecise/src/app_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newsexecise/src/bloc/everything_news_bloc.dart';
import 'package:newsexecise/src/bloc/headline_news_bloc.dart';

String replacementUrlA;
String kApiKey;

class NewsExerciseApp<B> extends StatefulWidget {
  final void Function(BuildContext context, B bloc) onDispose;
  final B Function(BuildContext context, B bloc) builder;
  final Widget child;
  final String url;
  final String apiKey;
  final Dio dio;

  static NewsExerciseAppState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AppConfig) as AppConfig)
        .newsExerciseAppState;
  }

  NewsExerciseApp({
    Key key,
    @required this.child,
    this.builder,
    this.onDispose,
    this.url,
    this.apiKey,
    this.dio,
  }) : super(key: key);
  createState() => NewsExerciseAppState<B>(dio);
}

class NewsExerciseAppState<B> extends State<NewsExerciseApp<B>> {
  B bloc;
  final Dio dio;

  NewsExerciseAppState(this.dio);

  bool _enabled = true;
  int _status = 0;
  List<DateTime> _events = [];

  final MethodChannel platform =
      MethodChannel('crossingthestreams.io/resourceResolver');

  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

  @override
  void initState() {
    super.initState();
    if (widget.builder != null) {
      bloc = widget.builder(context, bloc);
    }

    _requestIOSPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();

    initPlatformState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _onClickEnable(true);
    });
  }

  void _requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body)
              : null,
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
              },
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {});
  }

// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    BackgroundFetch.configure(
        BackgroundFetchConfig(
            minimumFetchInterval: 15,
            stopOnTerminate: false,
            enableHeadless: false,
            requiresBatteryNotLow: false,
            requiresCharging: false,
            startOnBoot: true,
            requiresStorageNotLow: false,
            requiresDeviceIdle: false,
            requiredNetworkType: NetworkType.ANY), (String taskId) async {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        headlineBloc.fetchCurrent(dio, performFunc: () {
          performTask(taskId);
        });
        everythingNewsBloc.fetchCurrent(widget.dio);
      });

      // This is the fetch-event callback.
      print("[BackgroundFetch] Event received $taskId");
      setState(() {
        _events.insert(0, new DateTime.now());
      });
      // IMPORTANT:  You must signal completion of your task or the OS can punish your app
      // for taking too long in the background.
    }).then((int status) {
      print('[BackgroundFetch] configure success: $status');
      setState(() {
        _status = status;
      });
    }).catchError((e) {
      print('[BackgroundFetch] configure ERROR: $e');
      setState(() {
        _status = e;
      });
    });

    // Optionally query the current BackgroundFetch status.
    int status = await BackgroundFetch.status;
    setState(() {
      _status = status;
    });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  performTask(String taskId) async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: 5));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your other channel id',
        'your other channel name',
        'your other channel description');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        'New content',
        'News content has been refreshed',
        scheduledNotificationDateTime,
        platformChannelSpecifics);

    BackgroundFetch.finish(taskId);
  }

  void _onClickEnable(enabled) {
    setState(() {
      _enabled = enabled;
    });
    if (enabled) {
      BackgroundFetch.start().then((int status) {
        print('[BackgroundFetch] start success: $status');
      }).catchError((e) {
        print('[BackgroundFetch] start FAILURE: $e');
      });
    } else {
      BackgroundFetch.stop().then((int status) {
        print('[BackgroundFetch] stop success: $status');
      });
    }
  }

  @override
  void dispose() {
    if (widget.onDispose != null) {
      widget.onDispose(context, bloc);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    replacementUrlA = widget.url;
    kApiKey = widget.apiKey;

    return AppConfig(
      bloc: bloc,
      newsExerciseAppState: this,
      dio: widget.dio,
      child: widget.child,
    );
  }
}
