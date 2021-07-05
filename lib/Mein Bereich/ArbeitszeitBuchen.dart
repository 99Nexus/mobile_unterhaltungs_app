import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_unterhaltungs_app/Data/Kalender/CalenderEntry.dart';
import 'package:mobile_unterhaltungs_app/Data/Person/Person.dart';
final calentryRef = FirebaseFirestore.instance
    .collection('calenderentry')
    .withConverter(
        fromFirestore: (snapshots, _) =>
            CalenderEntry.fromJson(snapshots.data()!),
        toFirestore: (calenderentry, _) => calenderentry.toJson());

class ArbeitszeitBeantragen extends StatelessWidget {
  ArbeitszeitBeantragen({Key? key,required this.user})
      : initialDate = DateTime.now(),
        super(key: key);
  Person user;

  ArbeitszeitBeantragen.withinitDate(this.initialDate,this.user);

  final DateTime initialDate;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Urlaub Beantragen',
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Arbeitszeit Buchen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
              child: Column(
            children: [
              InputDatePickerFormField(
                firstDate: DateTime(_now.year - 1, _now.month, _now.day),
                lastDate: DateTime(_now.year + 1, _now.month, _now.day),
                initialDate: _initialDate,
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
                        _start = DateTime(_start.year, _start.month, _start.day,
                            time.hour, time.minute);
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
                        print(_start.toString());
                      });
                    }
                  });
                },
              )
            ],
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Abbrechen')),
              ElevatedButton(
                  onPressed: () {
                    calentryRef.add(CalenderEntry(_user.nachname,_user.vorname,true, _start,_end,'attendance'));
                    Navigator.pop(context);
                    },
                  child: Text('Speichern'))
            ],
          )
        ],
      ),
    );
  }
}
