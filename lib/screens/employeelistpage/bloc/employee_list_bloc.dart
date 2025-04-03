import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'employee_list_event.dart';
part 'employee_list_state.dart';

class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState> {
  EmployeeListBloc() : super(EmployeeListInitial()) {
    on<EmployeeListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
