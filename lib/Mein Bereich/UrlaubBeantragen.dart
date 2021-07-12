import 'dart:ui';

import 'package:mobile_unterhaltungs_app/Data/Person/Person.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_unterhaltungs_app/Data/Kalender/Vacation.dart';

final vacationRef = FirebaseFirestore.instance
    .collection('vacation')
    .withConverter(
    fromFirestore: (snapshots, _) =>
        Vacation.fromJson(snapshots.data()!),
    toFirestore: (vacation, _) => vacation.toJson());



class UrlaubBeantragen extends StatelessWidget {
  UrlaubBeantragen({Key? key,required this.user})
      : initialDate = DateTime.now(),
        super(key: key);
  Person user;

  UrlaubBeantragen.withinitDate(this.initialDate,this.user);

  final DateTime initialDate;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Urlaub eintragen',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: OrderAttendance(initialDate,user),
    );
  }
}

class OrderAttendance extends StatefulWidget {
  const OrderAttendance(this.initialDate,this.user);



  final DateTime initialDate;
  final Person user;
  @override
  _OrderAttendanceState createState() => _OrderAttendanceState(initialDate,user);
}

class _OrderAttendanceState extends State<OrderAttendance> {
  _OrderAttendanceState(this._initialDate,this._user)
      : _start = _initialDate,
        _end = _initialDate;
  final Person _user;
  final DateTime _initialDate;
  DateTime _start;
  DateTime _end;
  DateTime _now = DateTime.now();
  int _insgesamtGebTage = 0;
  int _nochTage = 30;
  int _gebuchteTage = 0;
  DateTime _urlaubsbeginn = DateTime.now();
  DateTime _urlaubsende = DateTime.now();

  String _timeparser(DateTime dateTime) {
    return '${dateTime.hour > 9 ? dateTime.hour : '0${dateTime.hour}'}:${dateTime.minute > 9 ? dateTime.minute : '0${dateTime.minute}'}';
  }

  @override
  void initState() {}

  @override
  void dispose() {
    super.dispose();
  }

  void updateGebuchteTage()
  {
    setState(() {

        _gebuchteTage = _end.day - _start.day;

      if(_gebuchteTage < 0)
        {
          _gebuchteTage = 0;
        }
    });
  }

  void updateInsgesamtGebuchteTage()
  {
      setState(() {
        if(_insgesamtGebTage <= 30) {
          _insgesamtGebTage = 0 + _gebuchteTage;
        }
      });
  }



  void updateUebrigeTage()
  {
    setState(() {
      _nochTage = 30 - _insgesamtGebTage;
    });
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double ourwidth = width * 0.75;

    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Genommene Urlaubstage: $_insgesamtGebTage',
            style: TextStyle(
              fontSize: 15.0,
              decoration: TextDecoration.underline,
            ),
          ),
          Text(
            'Übrige Urlaubstage: $_nochTage',
            style: TextStyle(
              fontSize: 15.0,
              decoration: TextDecoration.underline,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 40.0)),
          Container(

            child:
            Text(
              'Urlaubsbeginn: ',
              style: TextStyle(

                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Form(
              child: Container(
                width: ourwidth,
                margin: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(width: 3.0, color: Colors.black),
                ),
                child:
                TextFormField(

                  decoration: InputDecoration(
                      icon: Icon(Icons.access_time),
                      hintText: _start.toString(),
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      )),

                  onTap: () {showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2001),
                      lastDate: DateTime(2022))
                      .then((date) {
                    setState(() {
                      _start = date!;
                      print('$_start');


                      updateGebuchteTage();
                      updateInsgesamtGebuchteTage();
                      updateUebrigeTage();
                    });
                  });},
                ),
              )
          ),

          Container(

            child:
            Text(
              'Urlaubsende: ',
              style: TextStyle(

                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Form(
              child: Container(
                width: ourwidth,
                margin: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(width: 3.0, color: Colors.black),
                ),
                child:
                TextFormField(

                  decoration: InputDecoration(
                      icon: Icon(Icons.access_time),
                      hintText: _end.toString(),
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      )),

                  onTap: () {showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2001),
                      lastDate: DateTime(2022))
                      .then((date) {
                    setState(() {
                      _end = date!;
                      print('$_end');

                      updateGebuchteTage();
                      updateInsgesamtGebuchteTage();
                      updateUebrigeTage();

                    });
                  });},
                ),
              )
          ),



          Text(
            'Die Eingabe entspricht Urlaubstagen: $_gebuchteTage',
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 40.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    vacationRef.add(Vacation(_user.firstName, _user.lastName, _insgesamtGebTage, _nochTage, _gebuchteTage, _urlaubsbeginn, _urlaubsende));

                    Navigator.pop(context);
                  },
                  child: Text('Beantragen'))
            ],
          )
        ],
      ),
    );
  }
}
