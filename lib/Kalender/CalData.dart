

import 'dart:collection';

import 'package:mobile_unterhaltungs_app/Data/Kalender/Attendance.dart';
import 'package:mobile_unterhaltungs_app/Data/Person/Person.dart';
import 'package:table_calendar/table_calendar.dart';

final now=DateTime.now();
final List<Attendance> exampleListToday=[Attendance(Person("Moritz"),true,DateTime(now.year,now.month,now.day,9,30),DateTime(now.year,now.month,now.day,15,00))];
final List<Attendance> exampleListTomorrow=[Attendance(Person("Stefan"),true,DateTime(now.year,now.month,now.day+1,11,00),DateTime(now.year,now.month,now.day+1,15,00))];

final calenderData=LinkedHashMap<DateTime,List<Attendance>>(equals: isSameDay ,hashCode: getHashCode)..addAll(_calSources);

final Map<DateTime,List<Attendance>> _calSources={
  DateTime.now():exampleListToday,
DateTime(now.year,now.month,now.day+1):exampleListTomorrow,
};

int getHashCode(DateTime key){
  return key.day * 1000000 + key.month * 10000 + key.year;
}