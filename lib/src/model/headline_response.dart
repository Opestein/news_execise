// To parse this JSON data, do
//
//     final headlineResponse = headlineResponseFromJson(jsonString);

import 'dart:convert';

//HeadlineResponse headlineResponseFromJson(String str) => HeadlineResponse.fromJson(json.decode(str));
//
//String headlineResponseToJson(HeadlineResponse data) => json.encode(data.toJson());

class HeadlineResponse {
  final String status;
  final int totalResults;
  final List<Article> articles;

  HeadlineResponse({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory HeadlineResponse.fromJson(Map<String, dynamic> json) =>
      HeadlineResponse(
        status: json["status"] == null ? null : json["status"],
        totalResults:
            json["totalResults"] == null ? null : json["totalResults"],
        articles: json["articles"] == null
            ? null
            : List<Article>.from(
                json["articles"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "totalResults": totalResults == null ? null : totalResults,
        "articles": articles == null
            ? null
            : List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

class Article {
  final Source source;
  final dynamic author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: json["source"] == null ? null : Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        url: json["url"] == null ? null : json["url"],
        urlToImage: json["urlToImage"] == null ? null : json["urlToImage"],
        publishedAt: json["publishedAt"] == null
            ? null
            : DateTime.parse(json["publishedAt"]),
        content: json["content"] == null ? null : json["content"],
      );

  Map<String, dynamic> toJson() => {
        "source": source == null ? null : source.toJson(),
        "author": author,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "url": url == null ? null : url,
        "urlToImage": urlToImage == null ? null : urlToImage,
        "publishedAt":
            publishedAt == null ? null : publishedAt.toIso8601String(),
        "content": content == null ? null : content,
      };
  Map<String, dynamic> toSaveJson() => {
        "title": title == null ? '' : title,
        "urlToImage": urlToImage == null ? '' : urlToImage,
        "publishedAt": publishedAt == null ? '' : publishedAt.toIso8601String(),
        "content": content == null ? '' : content,
      };
}

class Source {
  final dynamic id;
  final String name;

  Source({
    this.id,
    this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name == null ? null : name,
      };
}
