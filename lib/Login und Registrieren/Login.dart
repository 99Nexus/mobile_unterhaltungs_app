import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_unterhaltungs_app/Controller/AuthController.dart';
import 'package:mobile_unterhaltungs_app/Data/Person/Person.dart';
import 'package:mobile_unterhaltungs_app/main.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_unterhaltungs_app/Produktinformationen/ProductList.dart';

final usersCollection = FirebaseFirestore.instance
    .collection('Benutzer')
    .withConverter(
    fromFirestore: (snapshots, _) => Person.fromJson(snapshots.data()!),
    toFirestore: (person, _) => person.toJson());

void main() {
  runApp(Login(new Person('', '', '', '', ''), false));
}

class Login extends StatelessWidget {

  String title = 'Login';
  Person user = new Person('', '', '', '', '');
  bool showFastLogin = false;

  Login(Person user, bool showFastLogin) {

    this.user = user;
    this.showFastLogin = showFastLogin;
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',

      home: LoginHomePage(title: title, user: user, showFastLogin: showFastLogin,),
    );
  }
}

class LoginHomePage extends StatefulWidget {
  LoginHomePage({Key? key, required this.title, required this.user, required this.showFastLogin}) : super(key: key);

  final String title;
  Person user;
  bool showFastLogin = false;

  @override
  LoginHomePageState createState() => LoginHomePageState(user, showFastLogin);
}

class LoginHomePageState extends State {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String errorTextEmail = ' ';
  String errorTextPassword = ' ';

  int passwordTryCounter = 2;

  bool showFastLogin = false;
  bool enablePasswordInput = true;
  bool _initialized = false;
  bool _error = false;
  bool inputValidEmail = false;
  bool inputValidPassword = false;

  Person user = new Person('', '', '', '', '');
  AuthController authController = new AuthController();

  LoginHomePageState(Person user, bool showFastLogin) {

    // Vorname im Willkommenstext nur direkt nach Registrierung anzeigen
    if(showFastLogin == false)
      this.user.firstName = '';
    else
      this.user.firstName = user.firstName;

    this.user.lastName = user.lastName;
    this.user.position = user.position;
    this.user.email = user.email;
    this.user.password = user.password;
    this.showFastLogin = showFastLogin;
  }

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
        alignment: Alignment.center,

        // Gesamtspalte
        child: GridView.count(
          primary: true,
          childAspectRatio: 3.1,
          padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
          crossAxisSpacing: 10,
          crossAxisCount: 1,
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
                Visibility(
                  visible: !showFastLogin,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      user.firstName,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF681212),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Email-Eingabe
            Visibility(
              visible: !showFastLogin,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Container(
                    child: TextField (
                      enabled: enablePasswordInput,
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
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        counterText: errorTextEmail,
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
                  child: TextField (
                    enabled: enablePasswordInput,
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                // Anmelde-Button
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: (MediaQuery.of(context).size.width * 0.4) * 0.6,
                  padding: EdgeInsets.only(top: 30),
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 104, 18, 18)),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () {

                      setState(() {

                        // In das Hauptmenue wechseln sofern das Passwort korrekt ist
                        // und die Anmeldung direkt nach der Registrierung aufgerufen wurde
                        if(showFastLogin == true) {

                          inputValidPassword = authController.checkPassword(passwordController.text, user.password);
                          errorTextPassword = authController.errorTextPassword;

                          if(inputValidPassword)
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MyApp(user)));
                        }
                        // Falls die Anmelung nicht direkt nach der Registrierung aufgerufen wurde
                        // Prüfung der Eingaben erst zulassen, wenn die Eingabefelder gefüllt sind
                        else {

                          inputValidEmail = authController.checkEmail(emailController.text);
                          inputValidPassword = authController.checkPassword(passwordController.text, "");
                          errorTextEmail = authController.errorTextEmail;
                          errorTextPassword = authController.errorTextPassword;

                          if(inputValidEmail && inputValidPassword) {

                            inputValidPassword = false;
                            // Benutzer mit eingegebener Email und Passwort ermitteln
                            usersCollection
                                .where('Email', isEqualTo: emailController.text)
                                .where('Passwort', isEqualTo: passwordController.text)
                                .get()
                                .then((snapshot) => {

                              inputValidPassword = authController.checkLoginNumberOfUsers(snapshot.size),
                              errorTextPassword = authController.errorTextPassword,

                              if(inputValidPassword) {

                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (_) =>
                                        MyApp(user = new Person(
                                            snapshot.docs[0].data().firstName,
                                            snapshot.docs[0].data().lastName,
                                            snapshot.docs[0].data().position,
                                            snapshot.docs[0].data().email,
                                            snapshot.docs[0].data().password)))),
                              }
                              else {

                                if(passwordTryCounter == 0) {

                                  errorTextPassword = "Das Passwort wird für 60 Sekunden gesperrt",
                                  enablePasswordInput = false,

                                  Timer(Duration(seconds: 60), () {

                                    enablePasswordInput = true;
                                    passwordTryCounter = 2;
                                  }),
                                },

                                errorTextPassword = "Das Passwort ist nicht korrekt noch " + passwordTryCounter.toString() + " Versuche",
                                passwordTryCounter-1,
                              }
                            });
                          }
                        }
                      });
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

                // Produktsuche-Button
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: (MediaQuery.of(context).size.width * 0.4) * 0.6,
                  padding: EdgeInsets.only(top: 30),
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 104, 18, 18)),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () {

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => ProductList()));
                    },
                    child: Text(
                      'Produktsuche',
                      style: TextStyle(
                        fontSize: 19,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
