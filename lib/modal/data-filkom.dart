import 'dart:convert';

class DataFILKOM {
  String title;
  String description;
  String link;
  String pubdate;
  String creator;
  final String idNews;
  DataFILKOM(
      {this.title,
      this.description,
      this.link,
      this.pubdate,
      this.creator,
      this.idNews});
  factory DataFILKOM.fromJson(Map<String, dynamic> json) {
    return DataFILKOM(
      idNews: json['id_news'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      link: json['link'] as String,
      pubdate: json['pubdate'] as String,
      creator: json['creator'] as String,
    );
  }
  static Map<String, dynamic> toJson(DataFILKOM userData) {
    return {
      'title': userData.title,
      'description': userData.description,
      'link': userData.link,
      'pubdate': userData.pubdate,
      'creator': userData.creator,
    };
  }

  static Map<String, dynamic> toJsonWithId(DataFILKOM userData, String id) {
    return {
      'id': id,
      'title': userData.title,
      'description': userData.description,
      'link': userData.link,
      'pubdate': userData.pubdate,
      'creator': userData.creator,
    };
  }
}
