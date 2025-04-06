// presentation/screens/employee_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jigar_developer_flutter_assigments/common_widgets/custom_app_bar.dart';
import 'package:jigar_developer_flutter_assigments/utils/app_color.dart';
import 'package:jigar_developer_flutter_assigments/utils/app_images.dart';
import 'package:jigar_developer_flutter_assigments/utils/strings.dart';
import '../../../main.dart';
import '../../addemployeepage/bloc/add_employee_bloc.dart';
import '../../addemployeepage/view/add_employee_screen.dart';
import '../../addemployeepage/view/edit_employee_screen.dart';
import '../bloc/employee_bloc.dart';
import '../model/employee.dart';
import '../repository/employee_repository.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: const CustomAppBar(title: lblEmployeeList),
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EmployeeLoaded) {
            final isEmpty = state.current.isEmpty && state.previous.isEmpty;

            if (isEmpty) {
              // No data found screen
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppImages.noEmployeeImage,
                        // make sure this image exists in assets
                        height: 200,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "No employee records found",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Current Employees',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  ...state.current.map((e) => InkWell(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider<AddEmployeeBloc>(
                              create: (context) => AddEmployeeBloc(
                                  repository: employeeRepository),
                              child: EditEmployeeScreen(employee: e),
                            ),
                          ),
                        );

                        if (result == true) {
                          context.read<EmployeeBloc>().add(LoadEmployees());
                        }
                      },
                      child: _buildEmployeeTile(context, e))),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Previous Employees',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  ...state.previous.map((e) => InkWell(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider<AddEmployeeBloc>(
                              create: (context) => AddEmployeeBloc(
                                  repository: employeeRepository),
                              child: EditEmployeeScreen(employee: e),
                            ),
                          ),
                        );

                        if (result == true) {
                          context.read<EmployeeBloc>().add(LoadEmployees());
                        }
                      },
                      child: _buildEmployeeTile(context, e))),
                ],
              );
            }
          } else {
            return const Center(child: Text('Something went wrong.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => AddEmployeeBloc(
                      repository: context.read<EmployeeRepository>(),
                    ),
                  ),
                  BlocProvider.value(
                    value: context.read<
                        EmployeeBloc>(), // ← Pass the existing EmployeeBloc
                  ),
                ],
                child: const AddEmployeeScreen(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmployeeTile(BuildContext context, Employee employee) {
    String formattedDateRange;

    if (employee.fromDate != null) {
      final from = _formatDate(employee.fromDate!);
      final to =
          employee.toDate != null ? _formatDate(employee.toDate!) : 'Present';
      formattedDateRange = "$from → $to";
    } else {
      formattedDateRange = 'Date not available';
    }

    return Dismissible(
      key: Key(employee.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Confirm Delete'),
            content: Text('Delete employee "${employee.name}"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) {
        context.read<EmployeeBloc>().add(DeleteEmployee(employee.id));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${employee.name} deleted')),
        );
      },
      child: ListTile(
        title: Text(employee.name),
        subtitle: Text(employee.role),
        trailing: Text(formattedDateRange),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')} "
        "${_monthName(date.month)} "
        "${date.year}";
  }

  String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}
