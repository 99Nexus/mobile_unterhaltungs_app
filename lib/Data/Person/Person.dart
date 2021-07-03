import 'package:json_annotation/json_annotation.dart';
part 'Person.g.dart';

@JsonSerializable()
class Person{
  Person(this.vorname,  this.nachname);
  String vorname;
  String nachname;

  factory Person.fromJson(Map<String, dynamic?> json)=>_$PersonFromJson(json);
  Map<String, dynamic?> toJson() =>_$PersonToJson(this);
}