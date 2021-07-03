import 'package:json_annotation/json_annotation.dart';
import 'Attendance.dart';
import 'package:mobile_unterhaltungs_app/Data/Person/Person.dart';
part 'CalenderEntry.g.dart';

@JsonSerializable(explicitToJson: true)
class CalenderEntry{
  CalenderEntry( this.owner,  this.attendance);
  final Person owner;
  final List<Attendance> attendance;

  factory CalenderEntry.fromJson(Map<String, dynamic?> json)=> _$CalenderEntryFromJson(json);
  Map<String,dynamic?> toJson()=> _$CalenderEntryToJson(this);
}