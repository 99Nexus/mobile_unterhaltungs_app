import 'package:json_annotation/json_annotation.dart';
part 'Attendance.g.dart';

@JsonSerializable()
class Attendance{
  Attendance(this.approved, this.start, this.end);
  bool approved;
  DateTime start;
  DateTime end;

  factory Attendance.fromJson(Map<String, dynamic?> json)=>_$AttendanceFromJson(json);
  Map<String, dynamic?> toJson()=>_$AttendanceToJson(this);
}