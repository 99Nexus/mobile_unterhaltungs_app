import 'package:json_annotation/json_annotation.dart';
part 'CalenderEntry.g.dart';

@JsonSerializable()
class CalenderEntry{
  CalenderEntry( this.nachname,this.vorname, this.approved,this.start,this.end,this.type);
  String vorname;
  String nachname;
  bool approved;
  DateTime start;
  DateTime end;
  String type;

  factory CalenderEntry.fromJson(Map<String, dynamic?> json)=> _$CalenderEntryFromJson(json);
  Map<String,dynamic?> toJson()=> _$CalenderEntryToJson(this);
}