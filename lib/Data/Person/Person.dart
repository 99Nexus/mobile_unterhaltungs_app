part 'Person.g.dart';

class Person{

  String firstName = '';
  String lastName = '';
  String position = '';
  String email = '';
  String password = '';
  String uid = '';

  Person(this.firstName, this.lastName, this.position, this.email, this.password);

  Person.withUID(this.uid);


  Person.fromJson(Map<String, dynamic?> json):
      firstName = json['Vorname'],
      lastName = json['Nachname'],
      position = json['Position'],
      email = json['Email'],
      password = json['Passwort'];

  Map<String, dynamic?> toJson() => {
    'Vorname': firstName,
    'Nachname': lastName,
    'Position': position,
    'Email': email,
    'Passwort': password,
  };
}