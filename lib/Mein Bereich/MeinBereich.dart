import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_unterhaltungs_app/Data/Person/Person.dart';
import 'package:mobile_unterhaltungs_app/Mein%20Bereich/UrlaubBeantragen.dart';
import 'package:mobile_unterhaltungs_app/Produktinformationen/ProductList.dart';
import 'NameContant.dart';
import 'package:mobile_unterhaltungs_app/Mein Bereich/ArbeitszeitBuchen.dart';

class MeinBereich extends StatelessWidget {
  String _name;
  int _arbeitszeit;

  //int _gebUrlaubstage;
  //int _vorUrlaubstage;

  MeinBereich(this._name, this._arbeitszeit);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mein Bereich')),
      body: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.account_box,
                size: 175.0,
              ),
              Column(
                children: [
                  Text(
                          _name,
                          style: TextStyle(
                          fontSize: 18.0
                        ),
                    ),
                      Text(
                          'Restarbeitszeit beträgt: $_arbeitszeit',
                            style: TextStyle(
                            fontSize: 18.0
                        ),
                      ),
                ],
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
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            ArbeitszeitErfassen()), //Hier kommt der Aufruf der Seite
                  ),
                  child: Text(
                    'Arbeitszeit eintragen',
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                color: Colors.teal[100],
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            UrlaubBeantragen()), //Hier kommt der Aufruf der Seite
                  ),
                  child: Text(
                    'Urlaubstage eintragen',
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                color: Colors.teal[200],
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () {
                    print("Dateien werden eingesehen");
                  },
                  child: Text(
                    'Meine Dateien',
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                color: Colors.teal[300],
              ),
            ],
          ))
        ],
      ),
    );
  }
}
