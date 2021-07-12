// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person(
    json['Vorname'] as String,
    json['Nachname'] as String,
    json['Position'] as String,
    json['Email'] as String,
    json['Passwort'] as String,
  );
}

Map<String, dynamic> _$PersonToJson(Person instance) =>
    <String, dynamic>{
      'Vorname': instance.firstName,
      'Nachname': instance.lastName,
      'Position': instance.position,
      'Email': instance.email,
      'Passwort': instance.password,
    };
