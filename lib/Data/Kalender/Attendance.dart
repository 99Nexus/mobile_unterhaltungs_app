import 'package:flutter/material.dart';
import 'package:mobile_unterhaltungs_app/Data/Kalender/CalenderEntry.dart';
import 'package:mobile_unterhaltungs_app/Data/Person/Person.dart';

class Attendance extends CalenderEntry{
  Attendance(Person person, this.confirmed,DateTime start, DateTime end):timeRange=DateTimeRange(start: start, end: end),super(person);
  bool confirmed;
  DateTimeRange timeRange;
}