import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayWidget extends StatelessWidget {
  final int year;
  final int month;
  final int day;

  const DayWidget(
      {super.key, required this.year, required this.month, required this.day});

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime(year, month, day);
    bool isWeekend =
        date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
    bool isToday = date.year == DateTime.now().year &&
        date.month == DateTime.now().month &&
        date.day == DateTime.now().day;

    return Container(
      width: 30,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day.toString(),
            style: TextStyle(
              color: isToday
                  ? Colors.orange
                  : (isWeekend ? Colors.red : Colors.cyan),
              fontSize: 16,
            ),
          ),
          Text(
            DateFormat.E().format(date),
            style: TextStyle(
              color: isToday
                  ? Colors.orange
                  : (isWeekend ? Colors.red : Colors.cyan),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
