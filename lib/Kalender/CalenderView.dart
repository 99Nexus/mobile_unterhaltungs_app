import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderView extends StatefulWidget {
  @override
  _CalenderViewState createState() => _CalenderViewState();
}

class _CalenderViewState extends State<CalenderView> {
  CalendarFormat _calendarFormat=CalendarFormat.month;
  DateTime _focusedDay=DateTime.now();
  DateTime? _selectedDay;

  /*double start=12.50;
  double end=15;
  GlobalKey _rowKey=GlobalKey();
  double _height_end=0;
  double _height_start=0;
  double _width=48;

  _getRowSize(){
    RenderBox renderBox=_rowKey.currentContext.findRenderObject();
    Size size= renderBox.size;
    setState(() {
      _height_end=size.height*(end-start);
      _height_start=size.height*(start-8);
    });
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) => _getRowSize());
  }*/
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
          calendarFormat: _calendarFormat,
          ),
          const SizedBox(height: 8.0),
          Expanded(
              child: Row(

                children: <Widget>[
                  Column(
                    children: [
                      Expanded(
                          //key: _rowKey,
                          child: Text("08:00")),
                      Expanded(child: Text("09:00")),
                      Expanded(child: Text("10:00")),
                      Expanded(child: Text("11:00")),
                      Expanded(child: Text("12:00")),
                      Expanded(child: Text("13:00")),
                      Expanded(child: Text("14:00")),
                      Expanded(child: Text("15:00")),
                      Expanded(child: Text("16:00")),
                      Expanded(child: Text("17:00")),
                      Expanded(child: Text("18:00")),
                    ],
                  ),
                  /*Column(
                    children: [
                      AnimatedContainer(
                        color: Colors.white,
                        width: _width,
                        height: _height_start,
                        duration: Duration(milliseconds: 1300),
                      ),
                      AnimatedContainer(
                        width: _width,
                        height: _height_end,
                        duration: Duration(milliseconds: 1300),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),*/
                ],
              ),
          )
        ]
      ),
    );
  }
}
