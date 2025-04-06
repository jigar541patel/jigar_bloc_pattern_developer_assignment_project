import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../common_widgets/custom_app_bar.dart';
import '../../../common_widgets/custom_calendar_dialog.dart';
import '../../../common_widgets/custom_text_field.dart';
import '../../../common_widgets/standard_text.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_images.dart';
import '../../../utils/strings.dart';
import '../bloc/add_employee_bloc.dart';
import '../bloc/add_employee_event.dart';
import '../bloc/add_employee_state.dart';
import '../../employeelistpage/bloc/employee_bloc.dart';
import '../../employeelistpage/model/employee.dart';

class EditEmployeeScreen extends StatefulWidget {
  final Employee employee;

  const EditEmployeeScreen({super.key, required this.employee});

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  late TextEditingController nameController;
  late TextEditingController selectedRoleEditTextController;

  String? _selectedRole;
  DateTime? selectedFromDate;
  DateTime? selectedToDate;
  String? formattedFromDate;
  String? formattedToDate;

  final List<String> _roles = [
    'Product Designer',
    'Flutter Developer',
    'QA Tester',
    'Product Owner'
  ];

  double currentWidth = 0;
  double currentHeight = 0;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.employee.name);
    selectedRoleEditTextController =
        TextEditingController(text: widget.employee.role);
    _selectedRole = widget.employee.role;
    selectedFromDate = widget.employee.fromDate;
    formattedFromDate =
        DateFormat('d MMM yyyy').format(widget.employee.fromDate!);

    if (widget.employee.toDate != null) {
      selectedToDate = widget.employee.toDate;
      formattedToDate = DateFormat('d MMM yyyy').format(widget.employee.toDate!);
    } else {
      formattedToDate = "No Date";
    }
  }

  @override
  Widget build(BuildContext context) {
    currentHeight = MediaQuery.of(context).size.height;
    currentWidth = MediaQuery.of(context).size.width;

    return
      BlocListener<AddEmployeeBloc, AddEmployeeState>(
        listener: (context, state) {
      if (state is UpdateEmployeeSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Edited Succesfully")),
        );

        Navigator.pop(context, true); // return true to trigger reload
      } else if (state is AddEmployeeFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Update failed: ${state.error}')),
        );
      }
    },
    child:
      Scaffold(
      backgroundColor: AppColor.whiteColor,
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(title: lblEditEmployee),
      body: BlocListener<AddEmployeeBloc, AddEmployeeState>(
        listener: (context, state) {
          if (state is AddEmployeeSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.read<EmployeeBloc>().add(LoadEmployees());
            Navigator.of(context).pop();
          } else if (state is AddEmployeeFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Stack(
          children: [
            editEmployeeWidget(),
            Positioned(bottom: 10, right: 10, child: submitButtonWidget()),
          ],
        ),
      ),
    ));
  }

  Widget editEmployeeWidget() {
    return Padding(
      padding: EdgeInsets.all(currentWidth * 0.016),
      child: Column(
        children: [
          SizedBox(height: currentHeight * 0.015),
          CustomTextField(
              controller: nameController,
              hintText: "Enter Employee Name",
              leadingIcon: AppImages.userIcon),
          SizedBox(height: currentHeight * 0.015),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColor.boxBorderColor, width: 2)),
            padding: EdgeInsets.symmetric(horizontal: currentWidth * 0.012),
            child: GestureDetector(
              onTap: _showRolePicker,
              child: AbsorbPointer(
                child: CustomTextField(
                  leadingIcon: AppImages.suitCaseIcon,
                  tailIcon: AppImages.downArrowIcon,
                  controller: selectedRoleEditTextController,
                  hintText: _selectedRole ?? 'Select Role',
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: currentHeight * 0.016),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => showFromDateCustomCalendar(context),
                    child: datePickerContainer(
                        formattedFromDate ?? "Today", AppImages.dateIcon),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: currentHeight * 0.025),
                  child: SvgPicture.asset(AppImages.rightArrowIcon, fit: BoxFit.none),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => showToDateCustomCalendar(context),
                    child: datePickerContainer(
                        formattedToDate ?? "No Date", AppImages.dateIcon),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget datePickerContainer(String label, String iconPath) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.textColor, width: 0.4),
        borderRadius: BorderRadius.circular(currentHeight * 0.006),
      ),
      child: Padding(
        padding: EdgeInsets.all(currentWidth * 0.03),
        child: Row(
          children: [
            SvgPicture.asset(iconPath, fit: BoxFit.none),
            SizedBox(width: currentWidth * 0.05),
            Expanded(
              child: StandardText(
                label: label,
                color: AppColor.textColor,
                align: TextAlign.start,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget submitButtonWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: currentWidth,
          color: AppColor.colorF2F2F2,
          height: 1,
          margin: const EdgeInsets.only(bottom: 10),
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: currentHeight * 0.01,
                  horizontal: currentWidth * 0.03),
              decoration: const BoxDecoration(
                  color: AppColor.colorEDF8FF,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: const StandardText(
                label: "Cancel",
                color: AppColor.primaryColor,
              ),
            ),
            SizedBox(width: currentWidth * 0.05),
            InkWell(
              // onTap: () {
              //   context.read<AddEmployeeBloc>().add(
              //     UpdateEmployee(
              //       id: widget.employee.id,
              //       name: nameController.text,
              //       role: _selectedRole!,
              //       fromDate: selectedFromDate!,
              //       toDate: selectedToDate,
              //     ),
              //   );
              // },

              onTap: () {
                final name = nameController.text.trim();

                if (name.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter employee name")),
                  );
                  return;
                }

                if (_selectedRole == null || _selectedRole!.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select a role")),
                  );
                  return;
                }

                if (selectedFromDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select from date")),
                  );
                  return;
                }

                if (selectedToDate != null && selectedToDate!.isBefore(selectedFromDate!)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("To date cannot be before from date")),
                  );
                  return;
                }

                context.read<AddEmployeeBloc>().add(
                  UpdateEmployee(
                    id: widget.employee.id,
                    name: name,
                    role: _selectedRole!,
                    fromDate: selectedFromDate!,
                    toDate: selectedToDate,
                  ),
                );
              },

              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: currentHeight * 0.01,
                    horizontal: currentWidth * 0.03),
                decoration: const BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: const StandardText(
                  label: "Update",
                  color: AppColor.whiteColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showRolePicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          shrinkWrap: true,
          children: _roles.map((role) {
            return ListTile(
              title: Text(role),
              onTap: () {
                setState(() {
                  _selectedRole = role;
                  selectedRoleEditTextController.text = role;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  void showFromDateCustomCalendar(BuildContext context) async {
    final selected = await showDialog<DateTime>(
      context: context,
      builder: (context) => const CustomCalendarDialog(isFromDate: true),
    );

    if (selected != null) {
      setState(() {
        selectedFromDate = selected;
        formattedFromDate = DateFormat('d MMM yyyy').format(selected);
      });
    }
  }

  void showToDateCustomCalendar(BuildContext context) async {
    final selected = await showDialog<DateTime>(
      context: context,
      builder: (context) => const CustomCalendarDialog(isFromDate: false),
    );

    if (selected != null) {
      setState(() {
        selectedToDate = selected;
        formattedToDate = DateFormat('d MMM yyyy').format(selected);
      });
    } else {
      setState(() {
        formattedToDate = "No Date";
        selectedToDate = null;
      });
    }
  }
}
