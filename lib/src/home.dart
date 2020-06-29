// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:newsexecise/src/app.dart';
import 'package:newsexecise/src/application.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsexecise/src/ui/home_screen.dart';

class ActiveEdgeHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return MaterialApp(
        title: 'News Exercise',
        color: Colors.grey,
        debugShowCheckedModeBanner: false,
        supportedLocales: application.supportedLocales(),
        home: HomeScreen());
  }
}
