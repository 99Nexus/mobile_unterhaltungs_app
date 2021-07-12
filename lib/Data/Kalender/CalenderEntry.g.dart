// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CalenderEntry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalenderEntry _$CalenderEntryFromJson(Map<String, dynamic> json) {
  return CalenderEntry(
    json['nachname'] as String,
    json['vorname'] as String,
    json['approved'] as bool,
    DateTime.parse(json['start'] as String),
    DateTime.parse(json['end'] as String),
    json['type'] as String,
    json['arbeitszeitStunde'] as int,
    json['taetigkeiten'] as String,
    json['arbeitszeitMinute'] as int,
  );
}

Map<String, dynamic> _$CalenderEntryToJson(CalenderEntry instance) =>
    <String, dynamic>{
      'vorname': instance.vorname,
      'nachname': instance.nachname,
      'approved': instance.approved,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'type': instance.type,
      'arbeitszeitStunde': instance.arbeitszeitStunde,
      'arbeitszeitMinute': instance.arbeitszeitMinute,
      'taetigkeiten': instance.taetigkeiten,
    };
