// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CalenderEntry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalenderEntry _$CalenderEntryFromJson(Map<String, dynamic> json) {
  return CalenderEntry(
    json['Nachname'] as String,
    json['Vorname'] as String,
    json['Approved'] as bool,
    DateTime.parse(json['Start'] as String),
    DateTime.parse(json['Ende'] as String),
    json['Typ'] as String,
  );
}

Map<String, dynamic> _$CalenderEntryToJson(CalenderEntry instance) =>
    <String, dynamic>{
      'Vorname': instance.vorname,
      'Nachname': instance.nachname,
      'Approved': instance.approved,
      'Start': instance.start.toIso8601String(),
      'Ende': instance.end.toIso8601String(),
      'Typ': instance.type,
    };
