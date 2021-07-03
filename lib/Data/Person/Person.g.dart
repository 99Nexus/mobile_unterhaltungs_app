// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person(
    json['vorname'] as String,
    json['nachname'] as String,
  );
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'vorname': instance.vorname,
      'nachname': instance.nachname,
    };
