import 'package:flutter/material.dart';
import 'package:mobile_unterhaltungs_app/Data/Kalender/CalenderEntry.dart';
import 'package:table_calendar/table_calendar.dart';

import 'CalData.dart';

class CalenderView extends StatefulWidget {
  @override
  _CalenderViewState createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  CalendarFormat _calendarFormat=CalendarFormat.month;
  late final ValueNotifier<List<CalenderEntry>> _selectedEvents;
  DateTime _focusedDay=DateTime.now();
  DateTime? _selectedDay;

  double start=10;
  double end=15;

  List<CalenderEntry> _getEventsForDay(DateTime day){
    return calenderData[day] ??[];
  }

  _onDaySelected(DateTime selectedDay, DateTime focusedDay){
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      _selectedEvents.value= _getEventsForDay(selectedDay);
    }
  }

  @override
  void initState() {
    _selectedDay=_focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kalender"),
      ),
      body: Column(
        children: <Widget>[
          TableCalendar(
          firstDay: DateTime(_focusedDay.year,_focusedDay.month-3,_focusedDay.day),
          lastDay: DateTime(_focusedDay.year,_focusedDay.month+3,_focusedDay.day),
          focusedDay: _focusedDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
          calendarFormat: _calendarFormat,
            onFormatChanged: (format){
            setState(() {
              _calendarFormat=format;
            });
            },
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: _onDaySelected,
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<CalenderEntry>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index].owner.vorname}'),
                        title: Text('${value[index].owner.vorname}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ]
      ),
    );
  }
}
