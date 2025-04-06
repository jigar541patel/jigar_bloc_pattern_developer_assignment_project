part of 'employee_bloc.dart';

abstract class EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final List<Employee> current;
  final List<Employee> previous;

  EmployeeLoaded({required this.current, required this.previous});
}
