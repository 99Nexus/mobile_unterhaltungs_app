import 'package:json_annotation/json_annotation.dart';
part 'CalenderEntry.g.dart';

@JsonSerializable()
class CalenderEntry{
  CalenderEntry( this.nachname,this.vorname, this.approved,this.start,this.end,this.type, this.arbeitszeitStunde, this.taetigkeiten, this.arbeitszeitMinute);
  String vorname;
  String nachname;
  bool approved;
  DateTime start;
  DateTime end;
  String type;
  int arbeitszeitStunde;
  int arbeitszeitMinute;
  String taetigkeiten;


  factory CalenderEntry.fromJson(Map<String, dynamic?> json)=> _$CalenderEntryFromJson(json);
  Map<String,dynamic?> toJson()=> _$CalenderEntryToJson(this);
}