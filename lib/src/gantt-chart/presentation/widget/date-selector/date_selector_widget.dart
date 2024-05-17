import 'package:flutter/material.dart';
import 'package:smartproduction_planorama/src/gantt-chart/presentation/widget/date-selector/week_widget.dart';

import '../../../../../common/constants.dart';
import '../../../../../shared/widget/neumorphism/neumorphism_container_widget.dart';

class DateSelectorWidget extends StatelessWidget {
  final ScrollController scrollController;
  const DateSelectorWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final int year = DateTime.now().year;

    List<WeekWidget> weeks = [];
    int weekNumber = 1;

    for (int month = 1; month <= 12; month++) {
      final int daysInMonth = DateUtils.getDaysInMonth(year, month);
      final firstDayOfMonth = DateTime(year, month, 1);
      final startWeekday = firstDayOfMonth.weekday;

      List<int> currentWeek = [];

      for (int day = 1; day <= daysInMonth; day++) {
        if (currentWeek.length == 7 || (day == 1 && startWeekday == 7)) {
          weeks.add(WeekWidget(
              weekNumber: weekNumber,
              days: List.from(currentWeek),
              year: year,
              month: month));
          currentWeek.clear();
          weekNumber++;
        }
        currentWeek.add(day);
      }

      if (currentWeek.isNotEmpty) {
        weeks.add(WeekWidget(
            weekNumber: weekNumber,
            days: List.from(currentWeek),
            year: year,
            month: month));
        weekNumber++;
      }
    }

    return NeumorphismContainerWidget(
      height: 80,
      borderRadius: 20,
      distance: NeumorphismConstants.distance,
      blur: NeumorphismConstants.blur,
      color: HexColors.primaryColor.shade900,
      inset: true,
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.cyan),
            onPressed: () {
              scrollController.animateTo(
                scrollController.offset - 100,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: scrollController,
              child: Row(
                children: weeks,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.cyan),
            onPressed: () {
              scrollController.animateTo(
                scrollController.offset + 100,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
        ],
      ),
    );
  }
}
