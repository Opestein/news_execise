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

class CardListItem extends StatefulWidget {
  @override
  _CardListItemState createState() => _CardListItemState();
}

class _CardListItemState extends State<CardListItem> {
  PageController _controller = PageController(viewportFraction: 0.9);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var injector = NewsExerciseApp.of(context);
      headlineBloc.fetchCurrent(injector.dio);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var injector = NewsExerciseApp.of(context);
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 310,
            child: StreamBuilder<HeadlineResponse>(
                stream: headlineBloc.behaviorSubject.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.articles.length > 0) {
                      return PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _controller,
                        itemCount: snapshot.data.articles.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPage(snapshot
                                        .data.articles
                                        .elementAt(index)))),
                            child: CardPageView(
                                snapshot.data.articles.elementAt(index)),
                          );
                        },
                      );
                    }
                    return Text('No Content');
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text('Error connecting to the server'));
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(blue)));
                  }
                }),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "All News",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class CardPageView extends StatelessWidget {
  final Article article;
  const CardPageView(this.article);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: CachedNetworkImage(
                  fadeInCurve: Curves.easeIn,
                  fadeInDuration: Duration(milliseconds: 400),
                  placeholder: (context, url) {
                    return Center(
                      child: Image.asset(
                        Assets.demo_avatar,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  imageUrl: article.urlToImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            article.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            '${getDayMonth(article.publishedAt.millisecondsSinceEpoch)}',
            style: TextStyle(fontSize: 12, color: kBlack87Color),
          )
        ],
      ),
    );
  }
}
