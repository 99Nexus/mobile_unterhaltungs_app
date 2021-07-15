import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_unterhaltungs_app/Data/Kalender/CalenderEntry.dart';
import 'package:mobile_unterhaltungs_app/Data/Person/Person.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_unterhaltungs_app/Mein Bereich/MeinBereich.dart';
import 'package:mobile_unterhaltungs_app/Hauptmenue/Hauptmenue.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final calentryRef = FirebaseFirestore.instance
    .collection('calenderentry')
    .withConverter(
    fromFirestore: (snapshots, _) =>
        CalenderEntry.fromJson(snapshots.data()!),
    toFirestore: (calenderentry, _) => calenderentry.toJson());

class ArbeitszeitBeantragen extends StatelessWidget {
  ArbeitszeitBeantragen({Key? key, required this.user})
      : initialDate = DateTime.now(),
        super(key: key);
  Person user;

  ArbeitszeitBeantragen.withinitDate(this.initialDate, this.user);

  final DateTime initialDate;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arbeitszeit eintragen',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: OrderAttendance(initialDate, user),
    );
  }
}

class OrderAttendance extends StatefulWidget {
  const OrderAttendance(this.initialDate, this.user);

  final DateTime initialDate;
  final Person user;

  @override
  _OrderAttendanceState createState() =>
      _OrderAttendanceState(initialDate, user);
}

class _OrderAttendanceState extends State<OrderAttendance> {
  _OrderAttendanceState(this._initialDate, this._user)
      : _start = _initialDate,
        _end = _initialDate;
  final Person _user;
  final DateTime _initialDate;
  DateTime _start;
  int _arbeitszeitStunde = 0;
  int _arbeitszeitMinute = 0;

  DateTime _end;
  DateTime _now = DateTime.now();

  void updateTaetigkeit(String tat) {
    setState(() {
      _taetigkeit = tat;
    });
  }

  String _taetigkeit = ' ';

  String _timeparser(DateTime dateTime) {
    return '${dateTime.hour > 9 ? dateTime.hour : '0${dateTime.hour}'}:${dateTime.minute > 9 ? dateTime.minute : '0${dateTime.minute}'}';
  }

  @override
  void initState() {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double ourwidth = width * 0.75;
    return Scaffold(


      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Datum',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Form(
              child: Column(
                children: [
                  Container(
                    width: ourwidth,
                    margin: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 3.0, color: Colors.black),
                    ),
                    child: Column(
                      children: [
                        TextFormField(

                          decoration: InputDecoration(
                              icon: Icon(Icons.access_time),
                              hintText: _start.day.toString() +"-"+ _start.month.toString() +"-"+ _start.year.toString(),
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
                            });
                          });},
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(Icons.access_time),
                              hintText: _timeparser(_start),
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              )),
                          onTap: () {
                            showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(hour: 8, minute: 0))
                                .then((time) {
                              if (time != null) {
                                setState(() {
                                  _start = DateTime(_start.year, _start.month,
                                      _start.day, time.hour, time.minute);
                                  int tmp = _end.hour - _start.hour;

                                  if(tmp >= 0)
                                    {
                                      _arbeitszeitStunde = _end.hour - _start.hour;
                                      _arbeitszeitMinute = _end.minute - _start.minute;
                                    }


                                  print(_start.toString());
                                });
                              }
                            });
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(Icons.access_time),
                              hintText: _timeparser(_end),
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              )),
                          onTap: () {
                            showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(hour: 16, minute: 0))
                                .then((time) {
                              if (time != null) {
                                setState(() {
                                  _end = DateTime(_end.year, _end.month, _end.day,
                                      time.hour, time.minute);
                                  _arbeitszeitStunde = _end.hour - _start.hour;
                                  _arbeitszeitMinute = _end.minute - _start.minute;
                                  print(_start.toString());
                                });
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  )
                ],
              )),
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Text(
              'Arbeitsstunden',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: ourwidth,
              margin: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(width: 3.0, color: Colors.black),
              ),
              child: TextField(
                decoration: InputDecoration(
                    icon: Icon(Icons.access_time),
                    hintText: _arbeitszeitStunde.toString() + "Std "  + _arbeitszeitMinute.toString() + "Min",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    )),
              ),
            ),
            Text(
              'Tätigkeit',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: ourwidth,
              margin: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(width: 3.0, color: Colors.black),
              ),
              child: TextField(
                onChanged: updateTaetigkeit,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tätigkeit: ',
                ),
              ),
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 104, 18, 18),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(MaterialPageRoute(
                        builder: (context) =>
                            MeinBereich(_user, _arbeitszeitStunde, _arbeitszeitMinute)));
                    Navigator.push(context, MaterialPageRoute(builder: (_) => MeinBereich(_user, _arbeitszeitStunde, _arbeitszeitMinute)));
                  },
                  child: Text('Abbrechen')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 104, 18, 18),
                  ),
                  onPressed: () {
                    calentryRef.add(CalenderEntry(
                        _user.lastName,
                        _user.firstName,
                        true,
                        _start,
                        _end,
                        'attendance',
                        _arbeitszeitStunde,
                        _taetigkeit,
                        _arbeitszeitMinute));
                    Navigator.push(context, MaterialPageRoute(builder: (_) => MeinBereich(_user, _arbeitszeitStunde, _arbeitszeitMinute)));
                  },
                  child: Text('Speichern'))
            ],
          )
        ],
      ),
    );
  }
}
