import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'NewsConstant.dart';
import 'News.dart';
import 'NewsDetail.dart';
import 'package:mobile_unterhaltungs_app/Controller/AuthController.dart';

import 'NewsList.dart';

class NewsAdding extends StatefulWidget {
  @override
  NewsAddingState createState() => NewsAddingState();
}

class NewsAddingState extends State<NewsAdding> {

  final titleController = TextEditingController();
  final articleController = TextEditingController();
  final authorController = TextEditingController();

  String errorTextTitle = ' ';
  String errorTextArticle = ' ';
  String errorTextAuthor = ' ';

  bool inputValid = false;

  AuthController authController = new AuthController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'images/teaser-unterhaltung.png',
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shadowColor: Colors.transparent,
        toolbarHeight: 80,
      ),
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20.0),
                child: Text(
                  "News anlegen",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Container(
                child: Text(
                  'Titel',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.all(20.0),
                child: TextField (
                  controller: titleController,
                  textAlign: TextAlign.center,
                  cursorColor: Color.fromARGB(255, 104, 18, 18),
                  maxLines: 1,
                  maxLength: 30,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Arial',
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0.0),
                    border: OutlineInputBorder(),
                    counterText: errorTextTitle,
                    counterStyle: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Container(
                child: Text(
                  'Artikel',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.all(20.0),
                child: TextField (
                  controller: articleController,
                  textAlign: TextAlign.center,
                  cursorColor: Color.fromARGB(255, 104, 18, 18),
                  maxLines: 1,
                  maxLength: 30,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Arial',
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0.0),
                    border: OutlineInputBorder(),
                    counterText: errorTextArticle,
                    counterStyle: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Container(
                child: Text(
                  'Author',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.all(20.0),
                child: TextField (
                  controller: authorController,
                  textAlign: TextAlign.center,
                  cursorColor: Color.fromARGB(255, 104, 18, 18),
                  maxLines: 1,
                  maxLength: 30,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Arial',
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0.0),
                    border: OutlineInputBorder(),
                    counterText: errorTextAuthor,
                    counterStyle: TextStyle(
                      fontSize: 10,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
                height: (MediaQuery.of(context).size.width*0.4)*0.6,
                padding: EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 104, 18, 18),
                  ),
                  child: Text('Anlegen'),
                    onPressed: () async {

                      setState(() {


                        allNews.add(new News(title: '${titleController.text}', article: '${articleController.text}', author: '${authorController.text}'));
                        //Navigator.push(context, MaterialPageRoute(builder: (_) => NewsList()));
                        Navigator.pop(context);
                      });
                    }
                ),
              )
            ],
        ),
      ),
    );

  }

}