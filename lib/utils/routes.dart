import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jigar_developer_flutter_assigments/utils/route_names.dart';

import '../screens/addemployeepage/bloc/add_employee_bloc.dart';
import '../screens/employeelistpage/bloc/employee_list_bloc.dart';
import '../screens/employeelistpage/view/employee_list_screen.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeEmployeeList:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => EmployeeListBloc(),
                  child: const EmployeeListScreen(),
                ));
      case routeAddEmployee:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<AddEmployeeBloc>(
                      create: (BuildContext context) => AddEmployeeBloc(),
                    ),
                    BlocProvider<EmployeeListBloc>(
                      create: (BuildContext context) => EmployeeListBloc(),
                    ),
                  ],
                  child: const AddEmployeeScreen(),
                ),
            settings: settings);
    }
    return null;
  }
}
