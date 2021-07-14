import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_unterhaltungs_app/News/News.dart';
import 'package:mobile_unterhaltungs_app/News/NewsList.dart';

class NewsDetails extends StatelessWidget {

  News n;

  NewsDetails(this.n);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'images/teaser-unterhaltung.png',
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shadowColor: Colors.transparent,
        toolbarHeight: 80,
      ),
      body: Column(
        children: [
          //ElevatedButton(onPressed: , child: Text('Zurück')),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: BoxDecoration(color: Color.fromARGB(
                255, 104, 18, 18),),
            margin: const EdgeInsets.fromLTRB(0, 30, 0, 20),
            child:Text(
              '${n.title}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,

              ),

            ),
          ),
          Container(
            height: 20,
            margin: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Text(
                  '${n.author}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width*0.4,),
                Text('01.07.2021')
              ],
            ),
          ),
          SizedBox(height: 10.0,),
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
            child: Text(
              '${n.article}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
              ),
            ),
          ),
        ],
      ),
    );
  }



}