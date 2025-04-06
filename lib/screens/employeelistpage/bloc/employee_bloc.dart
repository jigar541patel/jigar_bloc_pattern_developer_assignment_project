import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/employee.dart';
import '../repository/employee_repository.dart';

part 'employee_event.dart';
part 'employee_state.dart';

// class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
//   EmployeeBloc() : super(EmployeeInitial()) {
//     on<EmployeeEvent>((event, emit) {
//       // TODO: implement event handler
//     });
//   }
// }

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository repository;

  EmployeeBloc(this.repository) : super(EmployeeLoading()) {
    on<LoadEmployees>(_onLoadEmployees);
    on<DeleteEmployee>(_onDeleteEmployee);
  }


  Future<void> _onLoadEmployees(
      LoadEmployees event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoading());
    final all = await repository.fetchAll();
    final now = DateTime.now();

    final current = all.where((e) =>
    e.toDate == null || e.toDate!.isAfter(now)).toList();

    final previous = all.where((e) =>
    e.toDate != null && e.toDate!.isBefore(now)).toList();

    emit(EmployeeLoaded(current: current, previous: previous));
  }

  Future<void> _onDeleteEmployee(
      DeleteEmployee event, Emitter<EmployeeState> emit) async {
    await repository.delete(event.id);
    add(LoadEmployees());
  }
}
