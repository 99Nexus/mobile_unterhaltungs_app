// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person(
    json['firstName'] as String,
    json['lastName'] as String,
    json['position'] as String,
    json['email'] as String,
    json['password'] as String,
  )..uid = json['uid'] as String;
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'position': instance.position,
      'email': instance.email,
      'password': instance.password,
      'uid': instance.uid,
    };
