import 'package:flutter/material.dart';

import '../../../../../common/constants.dart';
import '../../../../../shared/widget/neumorphism/neumorphism_container_widget.dart';
import 'week_widget.dart';

class DateSelectorWidget extends StatefulWidget {
  final ScrollController scrollController;
  const DateSelectorWidget({super.key, required this.scrollController});

  @override
  _DateSelectorWidgetState createState() => _DateSelectorWidgetState();
}

class _DateSelectorWidgetState extends State<DateSelectorWidget> {
  late List<WeekWidget> weeks;

  @override
  void initState() {
    super.initState();
    final int year = DateTime.now().year;
    weeks = _generateWeeksForYear(year);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToToday();
    });
  }

  void _scrollLeft() {
    widget.scrollController.animateTo(
      widget.scrollController.offset - 100,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    widget.scrollController.animateTo(
      widget.scrollController.offset + 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToToday() {
    final today = DateTime.now();
    double offset = 0;

    for (final week in weeks) {
      if (week.year == today.year && week.month == today.month) {
        if (week.days.contains(today.day)) {
          offset +=
              week.days.indexOf(today.day) * 34.0; // 30 (width) + 4 (margin)
          break;
        }
      }
      offset += week.days.length * 34.0; // 30 (width) + 4 (margin)
    }

    widget.scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphismContainerWidget(
      height: 80,
      borderRadius: 20,
      distance: NeumorphismConstants.distance,
      blur: NeumorphismConstants.blur,
      color: HexColors.primaryColor.shade900,
      inset: true,
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.cyan),
              onPressed: () => _scrollLeft(),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: widget.scrollController,
              child: Row(
                children: weeks,
              ),
            ),
          ),
          SizedBox(
            width: 50,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward, color: Colors.cyan),
              onPressed: () => _scrollRight(),
            ),
          )
        ],
      ),
    );
  }

  List<WeekWidget> _generateWeeksForYear(int year) {
    List<WeekWidget> weeks = [];
    DateTime currentDate = DateTime(year, 1, 1);
    int weekNumber = 1;

    // Align the current date to the first Monday of the year
    while (currentDate.weekday != DateTime.monday) {
      currentDate = currentDate.subtract(const Duration(days: 1));
    }

    while (currentDate.year <= year &&
        (currentDate.month < 12 ||
            (currentDate.month == 12 && currentDate.day <= 31))) {
      List<int> currentWeek = [];
      int currentMonth = currentDate.month;

      for (int i = 0; i < 7; i++) {
        if (currentDate.year == year) {
          currentWeek.add(currentDate.day);
        }
        currentDate = currentDate.add(const Duration(days: 1));
      }

      weeks.add(WeekWidget(
        weekNumber: weekNumber,
        days: List.from(currentWeek),
        year: year,
        month: currentMonth,
      ));
      weekNumber++;
    }

    return weeks;
  }
}
