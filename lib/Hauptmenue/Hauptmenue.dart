import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_unterhaltungs_app/Login%20und%20Registrieren/Login.dart';

void main() {
  runApp(Hauptmenue());
}

class Hauptmenue extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hauptmenue',

      home: HauptmenueHomePage(title: '',),
    );
  }
}

class HauptmenueHomePage extends StatefulWidget {
HauptmenueHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  HauptmenueHomePageState createState() => HauptmenueHomePageState();
}

class HauptmenueHomePageState extends State {

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
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 104, 18, 18)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  // Navigation zum Kalender
                },
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
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 104, 18, 18)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 104, 18, 18)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  // Navigation zu Mein Bereich
                },
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
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 104, 18, 18)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  // Navigation zu News
                },
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

      bottomNavigationBar: BottomNavigationBar(
        type : BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 104, 18, 18),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle_notifications_sharp ),
            label: '',
          ),
        ],
      ),
    );
  }
}
