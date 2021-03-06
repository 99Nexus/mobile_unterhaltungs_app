import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobile_unterhaltungs_app/Controller/AuthController.dart';
import 'package:mobile_unterhaltungs_app/Login%20und%20Registrieren/Login.dart';
import 'package:mobile_unterhaltungs_app/Data/Person/Person.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Benutzer-Sammlung - Firebase
final usersCollection = FirebaseFirestore.instance
    .collection('Benutzer')
    .withConverter(
    fromFirestore: (snapshots, _) => Person.fromJson(snapshots.data()!),
    toFirestore: (person, _) => person.toJson());

// Position-Sammlung - Firebase
final CollectionReference positionCollection = FirebaseFirestore.instance.collection('Position');

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('de_DE').then((_) => runApp(Registrieren()));
}

class Registrieren extends StatelessWidget {

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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String errorTextFirstName = ' ';
  String errorTextLastName = ' ';
  String errorTextEmail = ' ';
  String errorTextPassword = ' ';
  String positionDropdownValue = 'Mitarbeiter/in';

  bool inputValid = false;

  Person user = new Person('', '', '', '', '');
  AuthController authController = new AuthController();
  late final preferences;

  // Asynchrone Funktion um FlutterFire zu initialisieren
  void initializeFlutterFire() async {
    try {

      await Firebase.initializeApp();
    } catch(e) {
      print(e.toString());
    }
  }

  // Benutzer aus Datenspeicher holen
  void getUserFromDisk() async {

    SharedPreferences.getInstance().then((instance) => {

      user.firstName = instance.getString("userFirstName")!,
      user.lastName = instance.getString("userLastName")!,
      user.position = instance.getString("userPosition")!,
      user.email = instance.getString("userEmail")!,
      user.password = instance.getString("userPassword")!,
    });
  }

  @override
  void initState() {
    initializeFlutterFire();
    getUserFromDisk();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // Benutzer ist bereits in App gespeichert -> Login
    // Ansonsten -> Registrieren
    if(user.firstName.isNotEmpty &&
       user.lastName.isNotEmpty &&
       user.position.isNotEmpty &&
       user.email.isNotEmpty &&
       user.password.isNotEmpty) {
      return Login(user, true);
    }
    else {
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
          child: GridView.count(
            primary: true,
            childAspectRatio: 1.5,
            padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
            crossAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[

              // Vorname-Eingabe
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      'Vorname',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Container(
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
                        fontSize: 20,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Container(
                    child: TextField (
                      controller: lastNameController,
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
                        counterText: errorTextLastName,
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
                ],
              ),

              // Email-Eingabe
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Container(
                    child: TextField (
                      controller: emailController,
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
                        counterText: errorTextEmail,
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
                        fontSize: 20,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Container(
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
                        fontSize: 20,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Container(
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
                      items: <String>['Inhaber/in',
                        'Gesch??ftsf??hrer/in',
                        'Mitarbeiter/in',
                        'Student/in',
                        'Buchhalter/in']
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

              // leerer Container um GridView korrekt darzustellen
              Container(
              ),

              // Registrieren-Button
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
                height: (MediaQuery.of(context).size.width * 0.4) * 0.6,
                padding: EdgeInsets.only(top: 30),
                child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 104, 18, 18)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () async {

                    setState(() {

                      // Pr??fungen explizit aufrufen, um den Fehlertext zu setzen
                      inputValid = authController.checkRegisterInput(firstNameController.text,
                          lastNameController.text,
                          emailController.text,
                          passwordController.text);
                      errorTextFirstName = authController.errorTextFirstName;
                      errorTextLastName = authController.errorTextLastName;
                      errorTextEmail = authController.errorTextEmail;
                      errorTextPassword = authController.errorTextPassword;
                    });

                    // Zur Anmeldung wechseln, sofern die Eingaben den Konventionen entsprechen
                    if(inputValid) {

                      dynamic result = await authController.registerWithEmailAndPassword(emailController.text,
                          passwordController.text).then((value) {

                        setState(() {

                          if(value == null)
                            errorTextEmail = 'Email-Adresse ist ung??ltig';
                          else {

                            user = new Person(firstNameController.text, lastNameController.text,
                                positionDropdownValue, emailController.text, passwordController.text);
                            saveUserInCollection();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Login(user, true)));
                          }
                        });
                      });
                    }
                  },
                  child: Text(
                    'Registrieren',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Anmelde-Button
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
                height: (MediaQuery.of(context).size.width * 0.4) * 0.6,
                padding: EdgeInsets.only(top: 30),
                child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 104, 18, 18)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>
                        Login(new Person('', '', '', '', ''), false)));
                  },
                  child: Text(
                    'Anmelden',
                    style: TextStyle(
                      fontSize: 18,
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

  void saveUserInCollection() {

    int positionID = 2; // RollenID f??r Mitarbeiter/in als Standardwert
    int userID = 0;

    setState(() {

      // PositionsID zur jeweiligen Position ermitteln
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
            // Hinweis: snapshot.size speichert die L??nge der Collection
            if(snapshot.size > 0)
              userID = snapshot.size,

            // Benutzer in Datenbank hinzuf??gen
            // Hinweis: Funktion befindet sich in "then"-Abschnitt, da das Hinzuf??gen
            // erst nach Ermittlung der PositionsID und der aktuellen BenutzerID
            // ausgef??hrt werden soll
            usersCollection.doc(userID.toString())
                .set(Person(firstNameController.text,
                            lastNameController.text,
                            positionID.toString(),
                            emailController.text,
                            passwordController.text)),
          }),
        })
      });
    });
  }
}
