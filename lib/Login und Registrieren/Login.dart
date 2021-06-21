import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_unterhaltungs_app/Login%20und%20Registrieren/Login.dart';
import 'package:mobile_unterhaltungs_app/Hauptmenue/Hauptmenue.dart';

void main() {
  runApp(Login('', '', ''));
}

class Login extends StatelessWidget {

  String firstName = '';
  String lastName = '';
  String password = '';

  Login(String firstName, String lastName, String password) {

    this.firstName = firstName;
    this.lastName= lastName;
    this.password = password;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',

      home: LoginHomePage(title: '', firstName: firstName, lastName: lastName, password: password,),
    );
  }
}

class LoginHomePage extends StatefulWidget {
  LoginHomePage({Key? key, required this.title, required this.firstName, required this.lastName, required this.password}) : super(key: key);

  final String title;
  String firstName = '';
  String lastName = '';
  String password = '';

  @override
  LoginHomePageState createState() => LoginHomePageState(firstName, lastName, password);
}

class LoginHomePageState extends State {

  final passwordController = TextEditingController();
  String errorTextPassword = ' ';
  String firstName = '';
  String lastName = '';
  String password = '';

  LoginHomePageState(String firstName, String lastName, String password) {

    this.firstName = firstName;
    this.lastName = lastName;
    this.password = password;
  }

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
        child: Wrap(
          alignment: WrapAlignment.center,
          children: <Widget>[

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // Willkommenstext
                Container(
                  child: Text(
                    'Willkommen',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF681212),
                    ),
                  ),
                ),

                // Vorname
                Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    firstName,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF681212),
                    ),
                  ),
                ),
              ],
            ),

            // Passwort-Eingabe
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    'Passwort',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField (
                    controller: passwordController,
                    textAlign: TextAlign.center,
                    cursorColor: Color.fromARGB(255, 104, 18, 18),
                    maxLines: 1,
                    maxLength: 14,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Arial',
                    ),
                    autocorrect: false, // keine Autokorrektur da es ein Passwort ist
                    obscureText: true, // Zeichen werden als Punkte dargestellt
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      counterText: errorTextPassword,
                      counterStyle: TextStyle(
                        fontSize: 12,
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
              ],
            ),

            // Anmelde-Button
            Container(
              margin: EdgeInsets.all(20.0),
              width: MediaQuery.of(context).size.width * 0.5,
              height: (MediaQuery.of(context).size.width * 0.5) * 0.3,
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 104, 18, 18)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {

                  // In das Hauptmenue wechseln sofern das Passwort korrekt ist
                  if(checkPassword()) {
                    Hauptmenue hauptmenue = new Hauptmenue();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => hauptmenue.build(context)));
                  }
                },
                child: Text(
                  'Anmelden',
                  style: TextStyle(
                    fontSize: 22,
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

  bool checkPassword() {

    errorTextPassword = ' ';
    bool valid = false;

    setState(() {

      // Passwort prüfen
      if(passwordController.text.isEmpty) {

        errorTextPassword = 'Bitte Passwort eingeben';
        valid = false;
      } else if(passwordController.text.length < 8) {

        errorTextPassword = 'Passwort muss min. 8 Zeichen lang sein';
        valid = false;
      }else if(passwordController.text.compareTo(password) != 0) {

        errorTextPassword = 'Passwort stimmt nicht überein';
        valid = false;
      } else {

        valid = true;
      }
    });

    return valid;
  }
}
