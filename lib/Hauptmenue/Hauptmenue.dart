import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_unterhaltungs_app/Data/Person/Person.dart';
import 'package:mobile_unterhaltungs_app/Kalender/CalenderView.dart';
import 'package:mobile_unterhaltungs_app/Produktinformationen/ProductList.dart';
import 'package:mobile_unterhaltungs_app/Mein Bereich/MeinBereich.dart';

class Hauptmenue extends StatelessWidget {
  Hauptmenue(this.user);

  Person user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hauptmenue',
      home: HauptmenueHomePage(
        user: user,
      ),
    );
  }
}

class HauptmenueHomePage extends StatefulWidget {
  HauptmenueHomePage({Key? key, required this.user}) : super(key: key);

  Person user;

  @override
  HauptmenueHomePageState createState() => HauptmenueHomePageState(user);
}

class HauptmenueHomePageState extends State {
  HauptmenueHomePageState(this.user);

  Person user;

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
        alignment: Alignment.center,

        // Gesamtspalte
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Kalender
            Container(
              margin: const EdgeInsets.all(5.0),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.15,
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 104, 18, 18)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          CalenderView(user)), //Hier kommt der Aufruf der Seite
                ),
                child: Text(
                  'Kalender',
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Chats
            Container(
              margin: const EdgeInsets.all(5.0),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.15,
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 104, 18, 18)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  // Navigation zu Chats
                },
                child: Text(
                  'Chats',
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Mein Bereich
            Container(
              margin: const EdgeInsets.all(5.0),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.15,
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 104, 18, 18)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => MeinBereich(user, 15))),
                // Navigation zu Mein Bereich
                child: Text(
                  'Mein Bereich',
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // News
            Container(
              margin: const EdgeInsets.all(5.0),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.15,
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 104, 18, 18)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          ProductList()), //Hier kommt der Aufruf der Seite
                ),
                child: Text(
                  'News',
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
