import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:jigar_developer_flutter_assigments/data/local/employee_dao.dart';
import 'package:jigar_developer_flutter_assigments/screens/addemployeepage/view/add_employee_screen.dart';
import 'package:jigar_developer_flutter_assigments/utils/route_names.dart';

import '../data/local/isar_service.dart';
import '../main.dart';
import '../screens/addemployeepage/bloc/add_employee_bloc.dart';
import '../screens/employeelistpage/bloc/employee_bloc.dart';

import '../screens/employeelistpage/view/employee_list_screen.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    debugPrint('Navigating to: ${settings.name}');

    switch (settings.name) {
      case routeEmployeeList:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) =>
                EmployeeBloc(employeeRepository)..add(LoadEmployees()),
            child: const EmployeeListScreen(),
          ),
        );


      case routeAddEmployee:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AddEmployeeBloc(repository: employeeRepository),
            child:  AddEmployeeScreen(),
          ),
        );

    }
    return null;
  }
}
