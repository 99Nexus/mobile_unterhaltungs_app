// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Attendance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attendance _$AttendanceFromJson(Map<String, dynamic> json) {
  return Attendance(
    json['approved'] as bool,
    DateTime.parse(json['start'] as String),
    DateTime.parse(json['end'] as String),
  );
}

Map<String, dynamic> _$AttendanceToJson(Attendance instance) =>
    <String, dynamic>{
      'approved': instance.approved,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
    };
