// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Vacation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vacation _$VacationFromJson(Map<String, dynamic> json) {
  return Vacation(
    json['vorname'] as String,
    json['nachname'] as String,
    json['gebuchteUrlaubstage'] as int,
    json['nochUrlaubstage'] as int,
    json['eingegebeneUrlaubstage'] as int,
    DateTime.parse(json['urlaubsbeginn'] as String),
    DateTime.parse(json['urlaubsenede'] as String),
  );
}

Map<String, dynamic> _$VacationToJson(Vacation instance) => <String, dynamic>{
      'vorname': instance.vorname,
      'nachname': instance.nachname,
      'gebuchteUrlaubstage': instance.gebuchteUrlaubstage,
      'nochUrlaubstage': instance.nochUrlaubstage,
      'eingegebeneUrlaubstage': instance.eingegebeneUrlaubstage,
      'urlaubsbeginn': instance.urlaubsbeginn.toIso8601String(),
      'urlaubsenede': instance.urlaubsenede.toIso8601String(),
    };
