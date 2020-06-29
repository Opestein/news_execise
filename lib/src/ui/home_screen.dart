// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsexecise/src/ui/widgets/card_list_item.dart';
import 'package:newsexecise/src/ui/widgets/everything_item.dart';
import 'package:newsexecise/src/utils/app_utilities.dart';
import 'package:newsexecise/src/utils/assets.dart';
import 'package:newsexecise/src/utils/colors.dart';

class HomeScreen extends StatelessWidget {
  PageController _controller = PageController(viewportFraction: 0.9);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 24,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Today's News",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Today, ${getDayMonth(DateTime.now().millisecondsSinceEpoch)}',
                        style: TextStyle(fontSize: 12, color: kBlack87Color),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Latest News",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
          CardListItem(),
          EverythingItem(),
        ],
      ),
    );
  }
}
