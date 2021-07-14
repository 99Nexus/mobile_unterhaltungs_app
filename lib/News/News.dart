import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class News{
  String title;
  String article;
  String author;
  //DateTime date;

  News({
    required this.author,
    required this.article,
    required this.title,
    //required this.urlImage,
  });

  //factory News.fromJson(Map<String, dynamic?> json)=>_$NewsFromJson(json);

  //Map<String, dynamic?> toJson()=>_$NewsToJson(this);

  factory News.fromJson(Map<String, dynamic> json) => News(
    title: json['title'],
    article: json['article'],
    author: json['author'],
    //date: json['date'],

  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'article': article,
    'author': author,
    //'urlImage': urlImage,
  };
}