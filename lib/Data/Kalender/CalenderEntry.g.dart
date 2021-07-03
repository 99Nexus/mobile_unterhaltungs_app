// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CalenderEntry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalenderEntry _$CalenderEntryFromJson(Map<String, dynamic> json) {
  return CalenderEntry(
    Person.fromJson(json['owner'] as Map<String, dynamic>),
    (json['attendance'] as List<dynamic>)
        .map((e) => Attendance.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CalenderEntryToJson(CalenderEntry instance) =>
    <String, dynamic>{
      'owner': instance.owner.toJson(),
      'attendance': instance.attendance.map((e) => e.toJson()).toList(),
    };
