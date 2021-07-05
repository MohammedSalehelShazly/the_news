
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Article{

  final Source author;
  final String title;
  final String url;
  final String urlToImage;
  final String publishedAt;

  Article({this.author, this.title, this.url, this.urlToImage, this.publishedAt});

  factory Article.fromJson(Map<String ,dynamic> jsonData){
    return Article(
      author : Source.fromJson(jsonData['source']),
      title : jsonData['title'] ,
      url : jsonData['url'],
      urlToImage : jsonData['urlToImage'],
      publishedAt : jsonData['publishedAt'],
    );
  }

  Map<String, dynamic> toJson({@required fbAuthor ,@required fbTitle ,@required fbUrl ,@required fbUrlToImage ,@required fbUublishedAt}) => {
        "author": fbAuthor,
        "title": fbTitle,
        "url": fbUrl,
        "urlToImage": fbUrlToImage,
        "publishedAt": fbUublishedAt,
    };
    
}

class Source{
  final String name;

  Source({this.name});

  factory Source.fromJson(Map<String ,dynamic> jsonData)=>
      Source(
        name: jsonData['name'],
      );

      Map<String, dynamic> toJson() => {
        "name": name,
    };

}