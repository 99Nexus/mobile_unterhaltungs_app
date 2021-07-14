import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_unterhaltungs_app/Controller/AuthController.dart';
import 'package:mobile_unterhaltungs_app/Data/Person/Person.dart';
import 'package:mobile_unterhaltungs_app/main.dart';
import 'package:mobile_unterhaltungs_app/Produktinformationen/ProductList.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Benutzer Sammlung - Firebase
final usersCollection = FirebaseFirestore.instance
    .collection('Benutzer')
    .withConverter(
    fromFirestore: (snapshots, _) => Person.fromJson(snapshots.data()!),
    toFirestore: (person, _) => person.toJson());

void main() {

  WidgetsFlutterBinding.ensureInitialized();
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
  LoginHomePage({Key? key, required this.title, required this.user, required this.showFastLogin})
      : super(key: key);

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

  bool showFastLogin = false;
  bool inputValid = false;

  Person user = new Person('', '', '', '', '');
  AuthController authController = new AuthController();

  LoginHomePageState(Person user, bool showFastLogin) {

    // Vorname im Willkommenstext nur direkt nach Registrierung anzeigen
    // oder wenn der Benutzer im Datenspeicher hinterlegt ist
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

  // FlutterFire initialisieren
  void initializeFlutterFire() async {
    try {

      await Firebase.initializeApp();
    } catch(e) {
      print(e.toString());
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

            // Überschrift
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

                // Vorname - nur sichtbar wenn die Registrierung übersprungen
                // wird
                Visibility(
                  visible: showFastLogin,
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

            // Email-Eingabe - nur sichtbar wenn die Registrierung übersprungen
            // wird
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
                    onPressed: () async {

                      // Login wird mit Email-Eingabe aufgerufen
                      // Falls die Registrierung übersprungen wurde
                      if(!showFastLogin) {

                        setState(() {
                          // Prüfungen explizit aufrufen, um Fehlertexte zu setzen
                          inputValid = authController.checkLoginInputValid(emailController.text,
                                                                           passwordController.text,
                                                                           showFastLogin);
                          errorTextEmail = authController.errorTextEmail;
                          errorTextPassword = authController.errorTextPassword;
                        });

                        // Email und Passwort entsprechen den Vorgaben
                        // Z.B. 8-14 Passwortlänge
                        if(inputValid) {

                          dynamic result = await authController.loginWithEmailAndPassword(emailController.text,
                                                                                          passwordController.text);

                          // Benutzer mit eingegebener Email und Passwort ermitteln
                          usersCollection
                              .where('Email', isEqualTo: emailController.text)
                              .where('Passwort', isEqualTo: passwordController.text)
                              .get()
                              .then((snapshot) => {

                            // snapshot.size enthält Anzahl an passenden Datensätzen
                            if(snapshot.size > 0 && result != null) {

                              // Ermittelter Datensatz zur eingegebenen Email und
                              // Passwort
                              user = new Person(snapshot.docs[0].data().firstName,
                                                snapshot.docs[0].data().lastName,
                                                snapshot.docs[0].data().position,
                                                snapshot.docs[0].data().email,
                                                snapshot.docs[0].data().password),

                              // Benutzer in Datenspeicher speichern
                              // Zum Hauptmenü wechseln
                              saveUserInApp(user),
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) =>
                                      MyApp(user))),
                            }
                            else {

                              setState(() {
                                errorTextPassword = 'Die Eingaben sind nicht korrekt';
                              })
                            }
                          });
                        }
                      }
                      // Login wird ohne Email-Eingabe aufgerufen
                      // Falls der Benutzer sich grade registriert hat oder
                      // der Benutzer bereits in der App hinterlegt ist
                      else {

                        setState(() {
                          // Prüfungen explizit aufrufen, um den Fehlertext zu setzen
                          inputValid = authController.checkPassword(passwordController.text);
                          errorTextPassword = authController.errorTextPassword;
                        });

                        // Passwort entspricht Konventionen
                        if(inputValid) {

                          dynamic result = await authController.loginWithEmailAndPassword(user.email, passwordController.text);

                          if(result != null) {

                            // Benutzer in Datenspeicher speichern
                            // Zum Hauptmenü wechseln
                            saveUserInApp(user);
                            Navigator.push(context, MaterialPageRoute(builder: (_) => MyApp(user)));
                          }
                          else {

                            setState(() {
                              errorTextPassword = 'Die Eingaben sind nicht korrekt';
                            });
                          }
                        }
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

                      // Zur Produktsuche wechseln
                      Navigator.push(context,
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

  void saveUserInApp(user) async {

    final preference = await SharedPreferences.getInstance();

    // Benutzerattribute in Datenspeichern löschen um neue Daten einzutragen
    preference.remove("userFirstName");
    preference.remove("userLastName");
    preference.remove("userPosition");
    preference.remove("userEmail");
    preference.remove("userPassword");

    // Benutzerattribute in Datenspeichern hinterlegen
    preference.setString("userFirstName", user.firstName);
    preference.setString("userLastName", user.lastName);
    preference.setString("userPosition", user.position);
    preference.setString("userEmail", user.email);
    preference.setString("userPassword", user.password);
  }
}
