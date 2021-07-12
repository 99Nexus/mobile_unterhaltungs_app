import 'package:json_annotation/json_annotation.dart';
part 'Person.g.dart';

@JsonSerializable()
class Person{

  String firstName = '';
  String lastName = '';
  String position = '';
  String email = '';
  String password = '';
  String uid = '';

  Person(this.firstName, this.lastName, this.position, this.email, this.password);

  Person.withUID(this.uid);


  factory Person.fromJson(Map<String, dynamic?> json)=>_$PersonFromJson(json);
  Map<String, dynamic?> toJson() => _$PersonToJson(this);
}