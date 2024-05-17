import 'package:flutter/material.dart';

import 'day_widget.dart';

class WeekWidget extends StatelessWidget {
  final int weekNumber;
  final List<int> days;
  final int year;
  final int month;

  const WeekWidget(
      {required this.weekNumber,
      required this.days,
      required this.year,
      required this.month});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'KW$weekNumber',
              style: const TextStyle(color: Colors.cyan, fontSize: 16),
            ),
            Row(
              children: days
                  .map((day) => DayWidget(year: year, month: month, day: day))
                  .toList(),
            ),
          ],
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
