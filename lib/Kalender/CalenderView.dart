import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_unterhaltungs_app/Data/Kalender/CalenderEntry.dart';
import 'package:mobile_unterhaltungs_app/Data/Person/Person.dart';
import 'package:mobile_unterhaltungs_app/Mein%20Bereich/ArbeitszeitBeantragen.dart';
import 'package:mobile_unterhaltungs_app/Mein%20Bereich/UrlaubBeantragen.dart';
import 'package:table_calendar/table_calendar.dart';

//Abrufen aller Kalendereinträge, einbezogen wird die generierung in und aus JSON Dokumenten
final calentryRef = FirebaseFirestore.instance
    .collection('calenderentry')
    .withConverter(
        fromFirestore: (snapshots, _) =>
            CalenderEntry.fromJson(snapshots.data()!),
        toFirestore: (calenderentry, _) => calenderentry.toJson());

class CalenderView extends StatefulWidget {
  CalenderView(this.user);

  Person user;

  @override
  _CalenderViewState createState() => _CalenderViewState(user);
}

class _CalenderViewState extends State<CalenderView> {
  _CalenderViewState(this._user);

  Person _user;

  //Query aller Einträge
  late Query<CalenderEntry> _calentryQuery;

  //TODO :Was ist das für eine Variable calennderentry ist das bewusst?
  late Stream<QuerySnapshot<CalenderEntry>> _calennderentry;

  //Anzeigeformat des Kalenders
  CalendarFormat _calendarFormat = CalendarFormat.week;

  //Tag welcher in der App fokussiert werden soll
  DateTime _focusedDay = DateTime.now();

  //Vom nutzer ausgesuchter Tag im angezeigten Kalender
  DateTime? _selectedDay;
  late DateTime _dateTime;
  double start = 10;
  double end = 15;

  _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  //Die Ausgabe der Uhrzeit muss geändert werden von 9:0 Uhr auf 09:00 Uhr
  String _timeparser(DateTime dateTime) {
    return '${dateTime.hour > 9 ? dateTime.hour : '0${dateTime.hour}'}:${dateTime.minute > 9 ? dateTime.minute : '0${dateTime.minute}'}';
  }

  @override
  void initState() {
    _selectedDay = _focusedDay;
    _updateCalenderEntryQuery();
  }

  //Updaten der Query um auch neu hinzugefügte Daten anzeigen zu können
  void _updateCalenderEntryQuery() {
    setState(() {
      _calentryQuery = calentryRef;
      _calennderentry = _calentryQuery.snapshots();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        //Erzeugung des Kalenders
        TableCalendar(
          firstDay: DateTime(
              _focusedDay.year, _focusedDay.month - 3, _focusedDay.day),
          lastDay: DateTime(
              _focusedDay.year, _focusedDay.month + 3, _focusedDay.day),
          focusedDay: _focusedDay,
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarFormat: _calendarFormat,
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: _onDaySelected,
          locale: 'de_DE',
        ),
        const SizedBox(height: 8.0),
        //Aufbauen der am aufgewählten Tag arbeitenden Personen
        Expanded(
          child: StreamBuilder<QuerySnapshot<CalenderEntry>>(
            stream: _calennderentry,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final data = snapshot.requireData;
              return ListView.builder(
                itemCount: data.size,
                itemBuilder: (context, index) {
                  //Termine Rausfiltern die nicht am ausgewählten Tag arbeiten
                  if (data.docs[index].data().start.day == _selectedDay!.day) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                        //color: value[index].confirmed ? null : Colors.red,
                      ),
                      //Anzeigen des Namens und er Arbeitszeigten der Arbeitenden Personen
                      child: ListTile(
                        onTap: () =>
                            print('${data.docs[index].data().vorname}'),
                        title: Text(
                            '${data.docs[index].data().vorname} ${data.docs[index].data().nachname}'),
                        subtitle: Text(
                            'Von: ${_timeparser(data.docs[index].data().start)} bis: ${_timeparser(data.docs[index].data().end)}'),
                      ),
                    );
                  }
                  return Container();
                },
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              //TODO Farbe anpassen
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => UrlaubBeantragen.withinitDate(_selectedDay!, _user)),
                );

              },
              child: Text('Urlaub buchen'),
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 20),
              ),
            ),
            //Arbeitszeiten werden gesetzt indem das ausgewählte Datum mit übergeben werden
            ElevatedButton(//TODO farbe anpassen
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ArbeitszeitBeantragen.withinitDate(
                          _selectedDay!, _user)),
                );
              },
              child: Text('Arbeitszeit setzen'),
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 20),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
