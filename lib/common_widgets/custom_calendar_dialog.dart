import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jigar_developer_flutter_assigments/common_widgets/standard_text.dart';
import 'package:jigar_developer_flutter_assigments/utils/app_color.dart';

class CustomCalendarDialog extends StatefulWidget {
  final isFromDate;

  const CustomCalendarDialog({super.key, this.isFromDate});

  @override
  _CustomCalendarDialogState createState() => _CustomCalendarDialogState();
}

class _CustomCalendarDialogState extends State<CustomCalendarDialog> {
  DateTime? _selectedDate = DateTime.now();

  int intSelectedIndex = 0;

  void _selectQuickDate(String option) {
    DateTime now = DateTime.now();
    switch (option) {
      case 'Today':
        _selectedDate = now;
        break;
      case 'Next Monday':
        _selectedDate = now.add(Duration(days: (8 - now.weekday) % 7));
        break;
      case 'Next Tuesday':
        _selectedDate = now.add(Duration(days: (9 - now.weekday) % 7));
        break;
      case 'After 1 week':
        _selectedDate = now.add(const Duration(days: 7));
        break;
      case 'No Date':
        _selectedDate = null;
        break;
    }
    setState(() {});
  }

  void _openCalendar(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final dateStr = DateFormat('d MMM yyyy').format(_selectedDate!);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.isFromDate ? isFromDateSelector() : isToDateSelector(),

            const SizedBox(height: 12),
            // Calendar
            CalendarDatePicker(
              initialDate: _selectedDate,
              currentDate: _selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              onDateChanged: (newDate) {
                setState(() {
                  _selectedDate = newDate;
                });
              },
            ),
            const SizedBox(height: 8),
            // Selected date
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  _selectedDate != null
                      ? DateFormat('d MMM yyyy').format(_selectedDate!)
                      : "No Date",
                  style: const TextStyle(fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizedBox(height: 16),
            // Cancel / Save
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, _selectedDate);
                    },
                    child: const Text('Save'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget isFromDateSelector() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: InkWell(
              onTap: () {
                setState(() {
                  _selectQuickDate("Today");

                  intSelectedIndex = 0;
                });
              },
              child: Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: intSelectedIndex == 0
                          ? AppColor.primaryColor
                          : AppColor.colorEDF8FF),
                  child: StandardText(
                    label: "Today",
                    color: intSelectedIndex == 0
                        ? AppColor.whiteColor
                        : AppColor.primaryColor,
                  )),
            )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: InkWell(
              onTap: () {
                setState(() {
                  intSelectedIndex = 1;
                  _selectQuickDate("Next Monday");
                });
              },
              child: Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: intSelectedIndex == 1
                          ? AppColor.primaryColor
                          : AppColor.colorEDF8FF),
                  child: StandardText(
                    label: "Next Monday",
                    color: intSelectedIndex == 1
                        ? AppColor.whiteColor
                        : AppColor.primaryColor,
                  )),
            )),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
                child: InkWell(
              onTap: () {
                setState(() {
                  _selectQuickDate("Next Tuesday");

                  intSelectedIndex = 2;
                });
              },
              child: Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: intSelectedIndex == 2
                          ? AppColor.primaryColor
                          : AppColor.colorEDF8FF),
                  child: StandardText(
                    label: "Next Tuesday",
                    color: intSelectedIndex == 2
                        ? AppColor.whiteColor
                        : AppColor.primaryColor,
                  )),
            )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: InkWell(
              onTap: () {
                setState(() {
                  _selectQuickDate("After 1 week");
                  intSelectedIndex = 3;
                });
              },
              child: Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: intSelectedIndex == 3
                          ? AppColor.primaryColor
                          : AppColor.colorEDF8FF),
                  child: StandardText(
                    label: "After 1 week",
                    color: intSelectedIndex == 3
                        ? AppColor.whiteColor
                        : AppColor.primaryColor,
                  )),
            )),
          ],
        ),
      ],
    );
  }

  Widget isToDateSelector() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: InkWell(
              onTap: () {
                setState(() {
                  intSelectedIndex = 1;
                  _selectQuickDate("No Date");
                });
              },
              child: Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: intSelectedIndex == 1
                          ? AppColor.primaryColor
                          : AppColor.colorEDF8FF),
                  child: StandardText(
                    label: "No Date",
                    color: intSelectedIndex == 1
                        ? AppColor.whiteColor
                        : AppColor.primaryColor,
                  )),
            )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: InkWell(
              onTap: () {
                setState(() {
                  _selectQuickDate("Today");

                  intSelectedIndex = 0;
                });
              },
              child: Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: intSelectedIndex == 0
                          ? AppColor.primaryColor
                          : AppColor.colorEDF8FF),
                  child: StandardText(
                    label: "Today",
                    color: intSelectedIndex == 0
                        ? AppColor.whiteColor
                        : AppColor.primaryColor,
                  )),
            )),
          ],
        ),
      ],
    );
  }
}
