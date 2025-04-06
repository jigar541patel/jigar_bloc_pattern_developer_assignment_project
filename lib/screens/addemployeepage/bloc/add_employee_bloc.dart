import 'package:flutter_bloc/flutter_bloc.dart';
import '../../employeelistpage/model/employee.dart';
import '../../employeelistpage/repository/employee_repository.dart';
import 'add_employee_event.dart';
import 'add_employee_state.dart';

class AddEmployeeBloc extends Bloc<AddEmployeeEvent, AddEmployeeState> {
  final EmployeeRepository repository;

  AddEmployeeBloc({required this.repository}) : super(AddEmployeeInitial()) {
    on<SubmitEmployee>(_onSubmitEmployee);
    on<UpdateEmployee>(_onUpdateEmployee);
  }

  Future<void> _onSubmitEmployee(
    SubmitEmployee event,
    Emitter<AddEmployeeState> emit,
  ) async {
    emit(AddEmployeeSubmitting());

    try {
      final newEmployee = Employee()
        ..name = event.name
        ..role = event.role
        ..fromDate = event.fromDate
        ..toDate = event.toDate
        ..isCurrent = event.toDate == null;

      await repository.add(newEmployee);
      emit(AddEmployeeSuccess());
    } catch (e) {
      emit(AddEmployeeFailure(e.toString()));
    }
  }

  Future<void> _onUpdateEmployee(
    UpdateEmployee event,
    Emitter<AddEmployeeState> emit,
  ) async {
    emit(AddEmployeeSubmitting());

    try {
      final updatedEmployee = Employee()
        ..id = event.id
        ..name = event.name
        ..role = event.role
        ..fromDate = event.fromDate
        ..toDate = event.toDate
        ..isCurrent = event.toDate == null;

      await repository.add(updatedEmployee); // assuming this updates if ID exists
      emit(UpdateEmployeeSuccess());
    } catch (e) {
      emit(AddEmployeeFailure(e.toString()));
    }
  }
}
