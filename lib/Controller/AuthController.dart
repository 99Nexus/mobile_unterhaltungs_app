import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_unterhaltungs_app/Data/Person/Person.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthController {

  String errorTextFirstName = ' ';
  String errorTextLastName = ' ';
  String errorTextEmail = ' ';
  String errorTextPassword = ' ';
  bool validFirstName = false;
  bool validLastName = false;
  bool validEmail = false;
  bool validPassword = false;

  // Benutzer auf Basis eines Firebase-Benutzers erstellen
  Person _userFromFirebaseUser(User? user) {

    if(user != null)
      return Person.withUID(user.uid);

    return new Person.withUID('');
  }

  // Registrieren
  Future registerWithEmailAndPassword(String email, String password) async {

    try {

      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Anmelden
  Future loginWithEmailAndPassword(String email, String password) async {

    try {

      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Abmelden
  Future logout() async {

    try {

      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Vornamen prüfen
  bool checkFirstName(String firstName) {

    errorTextFirstName = ' ';

    if(firstName.isEmpty) {

      errorTextFirstName = 'Vorname darf nicht leer sein';
      return false;
    }

    return true;
  }

  // Nachnamen prüfen
  bool checkLastName(String lastName) {

    errorTextLastName = ' ';

    if(lastName.isEmpty) {

      errorTextLastName = 'Nachname darf nicht leer sein';
      return false;
    }

    return true;
  }

  // Email prüfen
  bool checkEmail(String email) {

    errorTextEmail = ' ';

    if(email.isEmpty) {

      errorTextEmail = 'Email-Adresse darf nicht leer sein';
      return false;
    }

    return true;
  }

  // Passwort prüfen
  bool checkPassword(String password) {

    errorTextPassword = ' ';

    if(password.isEmpty) {

      errorTextPassword = 'Passwort darf nicht leer sein';
      return false;
    }
    else if(password.length < 8) {

      errorTextPassword = '8 - 14 Zeichen erforderlich';
      return false;
    }
    // Prüfen ob das Passwort eine Zahl und ein Sonderzeichen hat
    else if(!password.contains(new RegExp(r'[0-9]')) ||
            !password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {

      errorTextPassword = 'Sonderzeichen und Zahl nötig';
      return false;
    }

    return true;
  }

  // Eingaben prüfen - Registrierung
  bool checkRegisterInput(String firstName, String lastName, String email, String password) {

    // Prüfungen explizit aufrufen, um Fehlertexte zu setzen
    validFirstName = checkFirstName(firstName);
    validLastName = checkLastName(lastName);
    validEmail = checkEmail(email);
    validPassword = checkPassword(password);

    if(validFirstName && validLastName && validEmail && validPassword)
      return true;

    return false;
  }

  // Eingaben prüfen - Anmeldung
  bool checkLoginInputValid(String email, String password, bool showFastLogin) {

    // Anmeldung wurde mit Email-Eingabe aufgerufen
    if(!showFastLogin) {

      // Prüfungen explizit aufrufen, um Fehlertexte zu setzen
      validEmail = checkEmail(email);
      validPassword = checkPassword(password);

      if(validEmail && validPassword)
        return true;
    }
    else if(checkPassword(password) && showFastLogin) {
      return true;
    }

    return false;
  }
}