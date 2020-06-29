import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:newsexecise/src/app.dart';
import 'package:newsexecise/src/bloc/everything_news_bloc.dart';
import 'package:newsexecise/src/bloc/headline_news_bloc.dart';
import 'package:newsexecise/src/model/headline_response.dart';
import 'package:newsexecise/src/ui/detail_screen.dart';
import 'package:newsexecise/src/utils/app_utilities.dart';
import 'package:newsexecise/src/utils/assets.dart';
import 'package:newsexecise/src/utils/colors.dart';

class EverythingItem extends StatefulWidget {
  @override
  _EverythingItemState createState() => _EverythingItemState();
}

class _EverythingItemState extends State<EverythingItem> {
  PageController _controller = PageController(viewportFraction: 0.9);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var injector = NewsExerciseApp.of(context);
      everythingNewsBloc.fetchCurrent(injector.dio);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<HeadlineResponse>(
        stream: everythingNewsBloc.behaviorSubject.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.articles.length > 0) {
              return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                return ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailPage(
                              snapshot.data.articles.elementAt(index)))),
                  leading: Container(
                    width: 70,
                    height: 70,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          fadeInCurve: Curves.easeIn,
                          fadeInDuration: Duration(milliseconds: 400),
                          placeholder: (context, url) {
                            return Center(
                              child: Image.asset(
                                Assets.demo_avatar,
                                height: 58,
                              ),
                            );
                          },
                          imageUrl: snapshot.data.articles
                              .elementAt(index)
                              .urlToImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    snapshot.data.articles.elementAt(index).title ?? '',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    timeLeft(
                        snapshot.data.articles.elementAt(index).publishedAt),
                    style: TextStyle(
                        fontSize: 12,
                        color: kBlack87Color.withOpacity(0.65),
                        fontWeight: FontWeight.w400),
                  ),
                );
              }, childCount: snapshot.data.articles.length ?? 0));
            } else {
              return SliverToBoxAdapter(
                  child: Center(
                child: Text('No Content'),
              ));
            }
          } else if (snapshot.hasError) {
            return SliverToBoxAdapter(
                child: Center(
              child: Text('Error while connecting to server'),
            ));
          } else {
            return SliverToBoxAdapter(
              child: Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(blue))),
            );
          }
        });
  }
}
