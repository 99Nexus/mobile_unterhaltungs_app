import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_unterhaltungs_app/Controller/AuthController.dart';
import 'package:mobile_unterhaltungs_app/Data/Person/Person.dart';
import 'package:mobile_unterhaltungs_app/Kalender/CalenderView.dart';
import 'package:mobile_unterhaltungs_app/Produktinformationen/ProductList.dart';
import 'package:mobile_unterhaltungs_app/Mein Bereich/MeinBereich.dart';
import 'package:mobile_unterhaltungs_app/Login%20und%20Registrieren/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  AuthController authController = new AuthController();
  late SharedPreferences preference;

  void getSharedPreferencesInstanz() async {

    preference = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    getSharedPreferencesInstanz();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,

        // Gesamtspalte
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            // Logout
            /*
            Container (
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.12,
              alignment: Alignment.center,
              child: Row (
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.logout),
                    iconSize: 50,
                    color: Color.fromARGB(255, 104, 18, 18),
                    onPressed: () async {

                        // Über FirebaseAuth ausloggen
                        authController.logout();

                        // Zu Login wechseln
                        Navigator.push(context, MaterialPageRoute(builder: (_) => Login(user, false)));
                      }
                    //},
                  ),
                  Text(
                    'Ausloggen',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ),*/

            // Kalender
            Container(
              margin: const EdgeInsets.all(5.0),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.12,
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
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.12,
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
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.12,
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 104, 18, 18)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => MeinBereich(user, 15,0))),
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
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.12,
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
