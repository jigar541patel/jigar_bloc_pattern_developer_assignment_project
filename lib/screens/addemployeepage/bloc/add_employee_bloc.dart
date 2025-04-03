import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_employee_event.dart';
part 'add_employee_state.dart';

class AddEmployeeBloc extends Bloc<AddEmployeeEvent, AddEmployeeState> {
  AddEmployeeBloc() : super(AddEmployeeInitial()) {
    on<AddEmployeeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
