import 'package:equatable/equatable.dart';

abstract class AddEmployeeState extends Equatable {
  const AddEmployeeState();

  @override
  List<Object?> get props => [];
}

class AddEmployeeInitial extends AddEmployeeState {}

class AddEmployeeSubmitting extends AddEmployeeState {}

class AddEmployeeSuccess extends AddEmployeeState {
  final String message;

  const AddEmployeeSuccess([this.message = 'Employee added successfully']);

  @override
  List<Object?> get props => [message];
}

class AddEmployeeFailure extends AddEmployeeState {
  final String error;

  const AddEmployeeFailure(this.error);

  @override
  List<Object?> get props => [error];
}
class UpdateEmployeeSuccess extends AddEmployeeState {}
