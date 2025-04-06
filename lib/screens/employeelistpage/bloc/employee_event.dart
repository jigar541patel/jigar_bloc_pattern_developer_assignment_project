part of 'employee_bloc.dart';


abstract class EmployeeEvent {}

class LoadEmployees extends EmployeeEvent {}

class DeleteEmployee extends EmployeeEvent {
  final int id;
  DeleteEmployee(this.id);
}