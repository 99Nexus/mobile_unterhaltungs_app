import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_unterhaltungs_app/Data/Kalender/Attendance.dart';
import 'package:mobile_unterhaltungs_app/Data/Kalender/CalenderEntry.dart';
import 'package:mobile_unterhaltungs_app/Data/Person/Person.dart';
import 'package:table_calendar/table_calendar.dart';

final calentryRef = FirebaseFirestore.instance
    .collection('calenderentry')
    .withConverter(
        fromFirestore: (snapshots, _) =>
            CalenderEntry.fromJson(snapshots.data()!),
        toFirestore: (calenderentry, _) => calenderentry.toJson());

class CalenderView extends StatefulWidget {
  @override
  _CalenderViewState createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  late Query<CalenderEntry> _calentryQuery;
  late Stream<QuerySnapshot<CalenderEntry>> _calennderentry;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  late final ValueNotifier<List<Attendance>> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  double start = 10;
  double end = 15;

  /*List<Attendance> _getEventsForDay(DateTime day){
    return calenderData[day] ??[];
  }*/

  /*_onDaySelected(DateTime selectedDay, DateTime focusedDay){
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      _selectedEvents.value= _getEventsForDay(selectedDay);
    }
  }*/
  //Die Ausgabe der Uhrzeit muss geändert werden von 9:0 Uhr auf 09:00 Uhr
  String _timeparser(DateTime dateTime) {
    return '${dateTime.hour > 9 ? dateTime.hour : '0${dateTime.hour}'}:${dateTime.minute > 9 ? dateTime.minute : '0${dateTime.minute}'}';
  }

  @override
  void initState() {
    _selectedDay = _focusedDay;
    // _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    _updateCalenderEntryQuery();
  }

  void _updateCalenderEntryQuery() {
    setState(() {
      _calentryQuery = calentryRef;
      _calennderentry = _calentryQuery.snapshots();
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> addUser() async {
      List<Attendance> calList = [
        Attendance(true, DateTime(2021, 07, 06, 10, 00),
            DateTime(2021, 07, 06, 15, 00))
      ];
      calentryRef.add(CalenderEntry(Person("Emre", 'Güler'), calList));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Kalender"),
      ),
      body: Column(children: <Widget>[
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
          //onDaySelected: _onDaySelected,
          //eventLoader: _getEventsForDay,
          locale: 'de_DE',
        ),
        const SizedBox(height: 8.0),
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
                      child: ListTile(
                        onTap: () =>
                            print('${data.docs[index].data().owner.vorname}'),
                        title:
                            Text('${data.docs[index].data().owner.nachname}'),
                        subtitle: Text('Platzhalter'
                            //'Von: ${_timeparser(value[index].timeRange.start)} bis: ${_timeparser(value[index].timeRange.end)}'),
                            ),
                      ));
                },
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              //TODO Funktionalität hinterlegen
              onPressed: () {
                print('Urlaub');
              },
              child: Text('Urlaub Buchen'),
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
              //TODO Funktionalität hinterlegen
              onPressed: () {
                addUser();
              },
              child: Text('Arbeitszeit setzten'),
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
