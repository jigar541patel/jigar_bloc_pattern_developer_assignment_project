import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jigar_developer_flutter_assigments/screens/employeelistpage/repository/employee_repository.dart';

import 'package:jigar_developer_flutter_assigments/theme/themes.dart';
import 'package:jigar_developer_flutter_assigments/utils/app_color.dart';
import 'package:jigar_developer_flutter_assigments/utils/route_names.dart';
import 'package:jigar_developer_flutter_assigments/utils/routes.dart';
import 'package:jigar_developer_flutter_assigments/utils/strings.dart';

import 'data/local/employee_dao.dart';
import 'data/local/isar_service.dart';
import 'package:provider/provider.dart';

late final EmployeeRepository employeeRepository;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isar = await IsarService().db;
  final dao = EmployeeDao(isar);
  employeeRepository = EmployeeRepository(dao);

  runApp(
    MultiProvider(
      providers: [
        Provider<EmployeeRepository>.value(value: employeeRepository),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: lblProjectTitle,
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      darkTheme: Themes.lightTheme,
      onGenerateRoute: Routes.onGenerateRoute,
      initialRoute: routeEmployeeList,
      supportedLocales: const [Locale('en', 'US')],
    );
  }
}
