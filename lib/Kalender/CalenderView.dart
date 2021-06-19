import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderView extends StatefulWidget {
  const CalenderView({Key? key}) : super(key: key);

  @override
  _CalenderViewState createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  CalendarFormat _calendarFormat=CalendarFormat.month;
  DateTime _focusedDay=DateTime.now();
  DateTime? _selectedDay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kalender"),
      ),
      body: TableCalendar(
        firstDay: DateTime(_focusedDay.year,_focusedDay.month-3,_focusedDay.day),
        lastDay: DateTime(_focusedDay.year,_focusedDay.month+3,_focusedDay.day),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
      ),
    );
  }
}
