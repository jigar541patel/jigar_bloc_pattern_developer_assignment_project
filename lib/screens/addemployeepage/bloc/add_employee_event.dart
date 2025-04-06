// blocs/add_employee_event.dart

import 'package:equatable/equatable.dart';

import '../../employeelistpage/model/employee.dart';

abstract class AddEmployeeEvent extends Equatable {
  const AddEmployeeEvent();

  @override
  List<Object?> get props => [];
}

class SubmitEmployee extends AddEmployeeEvent {
  final String name;
  final String role;
  final DateTime fromDate;
  final DateTime? toDate; // Make it nullable

  SubmitEmployee({
    required this.name,
    required this.role,
    required this.fromDate,
    this.toDate, // No `required` needed for nullable
  });
}
class UpdateEmployee extends AddEmployeeEvent {
  final int id;
  final String name;
  final String role;
  final DateTime fromDate;
  final DateTime? toDate;

  const UpdateEmployee({
    required this.id,
    required this.name,
    required this.role,
    required this.fromDate,
    this.toDate,
  });

  @override
  List<Object?> get props => [id, name, role, fromDate, toDate];
}
