
import 'package:isar/isar.dart';

part 'employee.g.dart';

@collection
class Employee {
  Id id = Isar.autoIncrement;

  late String name;
  late String role;
  DateTime? fromDate;
  DateTime? toDate;
  late bool isCurrent;
}
