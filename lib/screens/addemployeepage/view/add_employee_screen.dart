import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jigar_developer_flutter_assigments/common_widgets/custom_text_field.dart';
import 'package:jigar_developer_flutter_assigments/common_widgets/standard_text.dart';
import 'package:jigar_developer_flutter_assigments/screens/addemployeepage/bloc/add_employee_event.dart';
import 'package:jigar_developer_flutter_assigments/utils/app_color.dart';
import 'package:jigar_developer_flutter_assigments/utils/app_images.dart';
import '../../../common_widgets/custom_app_bar.dart';
import '../../../common_widgets/custom_calendar_dialog.dart';
import '../../../utils/strings.dart';
import '../../employeelistpage/bloc/employee_bloc.dart';
import '../bloc/add_employee_bloc.dart';
import '../bloc/add_employee_state.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  var currentWidth = 0.0;
  final TextEditingController nameController = TextEditingController();
  var currentHeight = 0.0;
  String? formattedFromDate;
  String? formattedToDate = "";
  DateTime? selectedFromDate;
  DateTime? selectedToDate;
  DateTime focusedFromDay = DateTime.now();
  DateTime? selectedFromDay;
  DateTime focusedToDay = DateTime.now();
  DateTime? selectedToDay;
  final List<String> _roles = [
    'Product Designer',
    'Flutter Developer',
    'QA Tester',
    'Product Owner'
  ];

  @override
  Widget build(BuildContext context) {
    currentHeight = MediaQuery.of(context).size.height;
    currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        resizeToAvoidBottomInset: false,
        appBar: const CustomAppBar(title: lblAddEmployee),
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
            child: Stack(children: [
              addEmployeeWidget(),
              Positioned(bottom: 10, right: 10, child: submitButtonWidget())
            ])));
  }

  String? _selectedRole;

  TextEditingController selectedRoleEditTextController =
      TextEditingController();

  // Widget submitButtonWidget() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.end,
  //     mainAxisAlignment: MainAxisAlignment.end,
  //     children: [
  //       Container(
  //         width: currentWidth,
  //         color: AppColor.colorF2F2F2,
  //         height: 1,
  //         margin: const EdgeInsets.only(bottom: 10),
  //       ),
  //       Row(
  //         children: [
  //           Container(
  //             padding: EdgeInsets.only(
  //                 left: currentWidth * 0.03,
  //                 right: currentWidth * 0.03,
  //                 top: currentHeight * 0.01,
  //                 bottom: currentHeight * 0.01),
  //             decoration: const BoxDecoration(
  //                 color: AppColor.colorEDF8FF,
  //                 borderRadius: BorderRadius.all(Radius.circular(5))),
  //             child: const StandardText(
  //               label: "Cancel",
  //               color: AppColor.primaryColor,
  //             ),
  //           ),
  //           SizedBox(
  //             width: currentWidth * 0.05,
  //           ),
  //           InkWell(
  //               onTap: () {
  //                 context.read<AddEmployeeBloc>().add(SubmitEmployee(
  //                       name: nameController.text,
  //                       role: _selectedRole!,
  //                       fromDate: selectedFromDate!,
  //                       toDate: selectedToDate,
  //                     ));
  //               },
  //               child: Container(
  //                 padding: EdgeInsets.only(
  //                     left: currentWidth * 0.03,
  //                     right: currentWidth * 0.03,
  //                     top: currentHeight * 0.01,
  //                     bottom: currentHeight * 0.01),
  //                 decoration: const BoxDecoration(
  //                     color: AppColor.primaryColor,
  //                     borderRadius: BorderRadius.all(Radius.circular(5))),
  //                 child: const StandardText(
  //                   label: "Submit",
  //                   color: AppColor.whiteColor,
  //                 ),
  //               ))
  //         ],
  //       ),
  //     ],
  //   );
  // }

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
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop(); // cancel
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: currentWidth * 0.03,
                  vertical: currentHeight * 0.01,
                ),
                decoration: const BoxDecoration(
                    color: AppColor.colorEDF8FF,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: const StandardText(
                  label: "Cancel",
                  color: AppColor.primaryColor,
                ),
              ),
            ),
            SizedBox(width: currentWidth * 0.05),
            GestureDetector(
              onTap: () {
                if (nameController.text.trim().isEmpty) {
                  showError("Please enter employee name");
                  return;
                }

                if (_selectedRole == null) {
                  showError("Please select a role");
                  return;
                }

                if (selectedFromDate == null) {
                  showError("Please select a From Date");
                  return;
                }

                if (selectedToDate != null &&
                    selectedToDate!.isBefore(selectedFromDate!)) {
                  showError("To Date cannot be before From Date");
                  return;
                }

                context.read<AddEmployeeBloc>().add(
                      SubmitEmployee(
                        name: nameController.text.trim(),
                        role: _selectedRole!,
                        fromDate: selectedFromDate!,
                        toDate: selectedToDate,
                      ),
                    );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: currentWidth * 0.03,
                  vertical: currentHeight * 0.01,
                ),
                decoration: const BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: const StandardText(
                  label: "Submit",
                  color: AppColor.whiteColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget addEmployeeWidget() {
    return Padding(
      padding: EdgeInsets.all(currentWidth * 0.016),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: currentHeight * 0.015,
          ),
          CustomTextField(
              controller: nameController,
              hintText: "Enter Employee Name",
              leadingIcon: AppImages.userIcon),
          SizedBox(
            height: currentHeight * 0.015,
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColor.boxBorderColor, width: 2)),
              padding: EdgeInsets.only(
                  left: currentWidth * 0.012, right: currentWidth * 0.012),
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
              )),
          Padding(
              padding: EdgeInsets.only(top: currentHeight * 0.016),
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            showFromDateCustomCalendar(context);
                            // showCalenderDialog(
                            //     selectedFromDay, focusedFromDay, true);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColor.textColor, width: 0.4),
                                borderRadius: BorderRadius.circular(
                                  currentHeight * 0.006,
                                )),
                            child: Padding(
                              padding: EdgeInsets.all(currentWidth * 0.03),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    AppImages.dateIcon,
                                    fit: BoxFit.none,
                                  ),
                                  SizedBox(
                                    width: currentWidth * 0.05,
                                  ),
                                  Expanded(
                                      child: StandardText(
                                    label: formattedFromDate == null
                                        ? "Today"
                                        : formattedFromDate!,
                                    color: AppColor.textColor,
                                    align: TextAlign.start,
                                    fontWeight: FontWeight.w500,
                                  )),
                                ],
                              ),
                            ),
                          ))),
                  Padding(
                    padding: EdgeInsets.only(
                        left: currentHeight * 0.025,
                        right: currentHeight * 0.025),
                    child: SvgPicture.asset(
                      AppImages.rightArrowIcon,
                      fit: BoxFit.none,
                    ),
                  ),
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            showToDateCustomCalendar(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColor.textColor, width: 0.4),
                                borderRadius: BorderRadius.circular(
                                  currentHeight * 0.006,
                                )),
                            child: Padding(
                              padding: EdgeInsets.all(currentWidth * 0.03),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    AppImages.dateIcon,
                                    fit: BoxFit.none,
                                  ),
                                  SizedBox(
                                    width: currentWidth * 0.05,
                                  ),
                                  Expanded(
                                      child: StandardText(
                                    label: formattedToDate == ""
                                        ? "No date"
                                        : formattedToDate!,
                                    color: AppColor.textColor,
                                    align: TextAlign.start,
                                    fontWeight: FontWeight.w500,
                                  )),
                                ],
                              ),
                            ),
                          ))),
                ],
              )),
        ],
      ),
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
      builder: (context) => const CustomCalendarDialog(
        isFromDate: true,
      ),
    );

    if (selected != null) {
      selectedFromDate = selected;
      formattedFromDate = DateFormat('d MMM yyyy').format(selected);
    }
  }

  void showToDateCustomCalendar(BuildContext context) async {
    final selected = await showDialog<DateTime>(
      context: context,
      builder: (context) => const CustomCalendarDialog(
        isFromDate: false,
      ),
    );

    if (selected != null) {
      selectedToDate = selected;
      formattedToDate = DateFormat('d MMM yyyy').format(selected);
    } else {
      formattedToDate = "No Date";
    }
  }
}
