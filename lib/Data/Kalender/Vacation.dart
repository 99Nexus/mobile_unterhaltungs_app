import 'package:mobile_unterhaltungs_app/Data/Person/Person.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Vacation.g.dart';


@JsonSerializable()
class Vacation{
  Vacation(this.vorname, this.nachname, this.gebuchteUrlaubstage, this.nochUrlaubstage, this.eingegebeneUrlaubstage, this.urlaubsbeginn, this.urlaubsenede);

  String vorname;
  String nachname;
  int gebuchteUrlaubstage;
  int nochUrlaubstage;
  int eingegebeneUrlaubstage;
  DateTime urlaubsbeginn;
  DateTime urlaubsenede;

  factory Vacation.fromJson(Map<String, dynamic?> json)=> _$VacationFromJson(json);
  Map<String,dynamic?> toJson()=> _$VacationToJson(this);
}