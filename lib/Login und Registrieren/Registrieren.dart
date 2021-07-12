import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobile_unterhaltungs_app/Login%20und%20Registrieren/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('de_DE').then((_) => runApp(Registrieren()));
}

class Registrieren extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registrieren',

      home: RegistrierenHomePage(title: ''),
    );
  }
}

class RegistrierenHomePage extends StatefulWidget {
  RegistrierenHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  RegistrierenHomePageState createState() => RegistrierenHomePageState();
}

class RegistrierenHomePageState extends State {

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  String errorTextFirstName = ' ';
  String errorTextLastName = ' ';
  String errorTextPassword = ' ';
  bool _initialized = false;
  bool _error = false;
  String positionDropdownValue = 'Mitarbeiter/in';

  // Asynchrone Funktion um FlutterFire zu initialisieren
  void initializeFlutterFire() async {
    try {

      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {

      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
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
        alignment: Alignment(0, -1),
        margin: EdgeInsets.only(top: 20),

        // Gesamtspalte
        child: Wrap(
          alignment: WrapAlignment.center,
          children: <Widget>[

            // Titel
            Container(
              margin: EdgeInsets.all(20.0),
              child: Text(
                'Benutzerkonto erstellen',
                style: TextStyle(
                  fontSize: 28,
                  fontFamily: 'Arial',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF681212),
                ),
              ),
            ),

            // Vorname-Eingabe
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    'Vorname',
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
                    controller: firstNameController,
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
                      counterText: errorTextFirstName,
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

            // Nachname-Eingabe
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    'Nachname',
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
                    controller: lastNameController,
                    textAlign: TextAlign.center,
                    cursorColor: Color.fromARGB(255, 104, 18, 18),
                    maxLines: 1,
                    maxLength: 40,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Arial',
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      border: OutlineInputBorder(),
                      counterText: errorTextLastName,
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

            // Positions-Eingabe
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    'Position',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  alignment: Alignment.center,
                  child: DropdownButtonFormField<String>(
                    value: positionDropdownValue,
                    iconSize: 30,
                    isExpanded: true,
                    style: const TextStyle(
                      fontSize: 22,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        positionDropdownValue = newValue!;
                      });
                    },
                    items: <String>['Inhaber/in', 'Geschäftsführer/in', 'Mitarbeiter/in', 'Student/in', 'Buchhalter/in']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        child: Container (
                          alignment: Alignment.center,
                          child: Text(
                            value = value,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        value: value,
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Registrieren-Button
            Container(
              margin: EdgeInsets.all(20.0),
              width: MediaQuery.of(context).size.width * 0.5,
              height: (MediaQuery.of(context).size.width * 0.5) * 0.3,
              child: OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(
                      255, 104, 18, 18)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {

                  bool firstNameValid = checkFirstName();
                  bool lastNameValid = checkLastName();
                  bool passwordValid = checkPassword();

                  // Zur Anmeldung wechseln, sofern die Eingaben korrekt sind
                  if(firstNameValid && lastNameValid && passwordValid) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Login(firstNameController.text, lastNameController.text, passwordController.text)));
                    saveUserInCollection();
                  }
                },
                child: Text(
                  'Registrieren',
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

  bool checkFirstName() {

    errorTextFirstName = ' ';
    bool valid = false;

    setState(() {

      // Benutzernamen prüfen
      if(firstNameController.text.isEmpty) {

        errorTextFirstName = 'Vorname darf nicht leer sein';
        valid = false;
      } else {

        errorTextFirstName = ' ';
        valid = true;
      }
    });

    return valid;
  }

  bool checkLastName() {

    errorTextLastName = ' ';
    bool valid = false;

    setState(() {

      // Benutzernamen prüfen
      if(lastNameController.text.isEmpty) {

        errorTextLastName = 'Nachname darf nicht leer sein';
        valid = false;
      } else {

        errorTextLastName = ' ';
        valid = true;
      }
    });

    return valid;
  }

  bool checkPassword() {

    errorTextPassword = ' ';
    bool foundNumber = false;
    bool foundSpecialChar = false;
    bool valid = false;

    setState(() {

      // Passwort prüfen
      if(passwordController.text.isEmpty) {

        errorTextPassword = 'Passwort darf nicht leer sein';
        valid = false;
      }
      else if(passwordController.text.length < 8) {

        errorTextPassword = 'Passwort muss zwischen 8 und 14 Zeichen lang sein';
        valid = false;
      }
      else {

        // Prüfen ob das Passwort eine Zahl und ein Sonderzeichen hat
        foundNumber = passwordController.text.contains(new RegExp(r'[0-9]'));
        foundSpecialChar = passwordController.text.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

        if(foundSpecialChar == false || foundNumber == false) {

          errorTextPassword = 'Muss min. ein Sonderzeichen und eine Zahl enthalten';
          valid = false;
        } else {

          errorTextPassword = ' ';
          valid = true;
        }
      }
    });

    return valid;
  }

  void saveUserInCollection() {

    CollectionReference usersCollection = FirebaseFirestore.instance.collection('Benutzer');
    CollectionReference positionCollection = FirebaseFirestore.instance.collection('Position');
    int positionID = 2; // RollenID für Mitarbeiter/in als Standardwert
    int userID = 0;
    List users;

    setState(() {

      // RollenID zur jeweiligen Rolle ermitteln
      positionCollection.where('Bezeichnung', isEqualTo: positionDropdownValue)
          .get()
          .then((snapshot) => {
        snapshot.docs.forEach((doc) => {

          positionID = int.parse(doc.id),

          // Aktuellste BenutzerID holen
          usersCollection
              .get()
              .then((snapshot) => {

                // BenutzerID aktualisieren, falls bereits User vorhanden sind
                // Sonst als erste ID "0" verwenden
                // Hinweis: snapshot.size speichert die Länge der Collection
                if(snapshot.size > 0)
                  userID = snapshot.size,

                // Benutzer in Datenbank hinzufügen
                // Hinweis: Funktion befindet sich in "then"-Abschnitt, da das Hinzufügen
                // erst nach Ermittlung der PositionsID und der aktuellen BenutzerID
                // ausgeführt werden soll
                usersCollection.doc(userID.toString()).set({
                  'Vorname': firstNameController.text,
                  'Nachname': lastNameController.text,
                  'Position': positionID,
                  'Passwort': passwordController.text
                }),
              }),
        })
      });
    });
  }
}
