import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_unterhaltungs_app/Data/Person/Person.dart';
import 'package:mobile_unterhaltungs_app/Mein Bereich/ArbeitszeitBeantragen.dart';
import 'package:mobile_unterhaltungs_app/Mein%20Bereich/UrlaubBeantragen.dart';
import 'package:mobile_unterhaltungs_app/Mein%20Bereich/MeineDateien.dart';

class MeinBereich extends StatelessWidget {
  Person user;
  int _arbeitszeit;
  int _arbeitszeitMinute;

  //int _gebUrlaubstage;
  //int _vorUrlaubstage;

  MeinBereich(this.user, this._arbeitszeit, this._arbeitszeitMinute);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Row(
            children: <Widget>[
              Icon(
                Icons.account_box,
                size: 175.0,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        "${user.firstName} ${user.lastName}",
                      style: TextStyle(fontSize: 18.0),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Restarbeitszeit beträgt: \n $_arbeitszeit Std $_arbeitszeitMinute Min",
                      style: TextStyle(fontSize: 18.0),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ],
          ),
          Expanded(
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 104, 18, 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
                        ),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ArbeitszeitBeantragen(
                              user: user,
                            )), //Hier kommt der Aufruf der Seite
                      ),
                      child: Text(
                        'Arbeitszeit eintragen',
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 104, 18, 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
                        ),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => UrlaubBeantragen(
                                user: user)), //Hier kommt der Aufruf der Seite
                      ),
                      child: Text(
                        'Urlaubstage eintragen',
                        style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ],
              )
          )
        ],
      ),
    );
  }
}
