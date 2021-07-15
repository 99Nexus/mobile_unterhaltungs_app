import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:mobile_unterhaltungs_app/News/NewsAdding.dart';
import 'NewsConstant.dart';
import 'News.dart';
import 'NewsDetail.dart';



class NewsList extends StatefulWidget {
  @override
  NewsListState createState() => NewsListState();
}

class NewsListState extends State<NewsList> {
  late List<News> newspl;
  String query = '';

  @override
  void initState() {
    super.initState();

    newspl = allNews;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      children: <Widget>[
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            color: Color.fromARGB(255, 104, 18, 18),
            child: Column(
              children: [
                Text(
                  "News",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40),
                ),
              ],
            ),
          )

          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: newspl.length,
            itemBuilder: (context, index) {
              final news = newspl[index];

              return buildnews(news, context);
            },
          ),
        ),
      ],
    ),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (_) =>
          NewsAdding()));
      },
      backgroundColor: Color.fromARGB(255, 104, 18, 18),
    ),
  );


  Widget buildnews(News news, BuildContext c) => ListTile(
    title: Text(news.title),
    subtitle: Text(news.author),
    onTap: () => Navigator.push(c,
        MaterialPageRoute(builder: (_) => NewsDetails(news)))
  );

}