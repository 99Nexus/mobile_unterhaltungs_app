
import 'package:mobile_unterhaltungs_app/Data/Person/Person.dart';

abstract class CalenderEntry{
  CalenderEntry(this.owner);
  Person owner;
}