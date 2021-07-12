import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_unterhaltungs_app/Data/Person/Person.dart';

class AuthController {

  //final FirebaseAuth _auth = FirebaseAuth.instance;
  String errorTextFirstName = ' ';
  String errorTextLastName = ' ';
  String errorTextEmail = ' ';
  String errorTextPassword = ' ';

  /*
  // Benutzer auf Basis eines Firebase-Benutzers erstellen
  Person _userFromFirebaseUser(User? user) {

    if(user != null)
      return Person.withUID(user.uid);

    return new Person.withUID('');
  }

  // Änderung der Benutzer-Authentifikation
  Stream<Person> get authChangeStreamUser {

    return _auth.authStateChanges().map((User? user) => _userFromFirebaseUser(user));
  }*/

  // Vornamen prüfen
  bool checkFirstName(String firstName) {

    errorTextFirstName = ' ';

    if(firstName.isEmpty) {

      errorTextFirstName = 'Darf nicht leer sein';
      return false;
    }

    return true;
  }

  // Nachnamen prüfen
  bool checkLastName(String lastName) {

    errorTextLastName = ' ';

    if(lastName.isEmpty) {

      errorTextLastName = 'Darf nicht leer sein';
      return false;
    }

    return true;
  }

  // Email prüfen
  bool checkEmail(String email) {

    errorTextEmail = ' ';

    if(email.isEmpty) {

      errorTextEmail = 'Darf nicht leer sein';
      return false;
    }

    return true;
  }

  // Passwort prüfen
  bool checkPassword(String password, String savedPassword) {

    errorTextPassword = ' ';

    if(password.isEmpty) {

      errorTextPassword = 'Darf nicht leer sein';
      return false;
    }
    else if(password.length < 8) {

      errorTextPassword = '8 - 14 Zeichen erforderlich';
      return false;
    }
    // Prüfen ob das Passwort eine Zahl und ein Sonderzeichen hat
    else if(!password.contains(new RegExp(r'[0-9]')) ||
            !password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {

      errorTextPassword = 'Min. Sonderzeichen und min. eine Zahl erforderlich';
      return false;
    }
    else if(savedPassword.compareTo("") != 0 && password.compareTo(savedPassword) != 0) {

      return false;
    }

    return true;
  }

  // Eingaben prüfen - Registrierung
  bool checkRegisterInput(String firstName, String lastName, String email, String password) {

    bool validFirstName = checkFirstName(firstName);
    bool validLastName = checkLastName(lastName);
    bool validEmail = checkEmail(email);
    bool validPassword = checkPassword(password, "");

    if(validFirstName && validLastName && validEmail && validPassword)
      return true;

    return false;
  }

  bool checkLoginNumberOfUsers(int numberOfUsers) {

    errorTextPassword = ' ';

    // Größe des Snapshots(Anzahl Dokumente in der Sammlung Benutzer mit
    // übereinstimmendem Vor-, Nachname und Passwort)
    if(numberOfUsers == 0) {

      errorTextPassword = 'Eingaben nicht korrekt - falsche Email oder falsches Passwort';
      return false;
    }

    return true;
  }
}