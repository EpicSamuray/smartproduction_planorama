import 'package:flutter/material.dart';

import '../../domain/model/gantt_task.dart';
import 'task_widget.dart';

class GanttGridWidget extends StatelessWidget {
  final List<GanttTask> tasks;
  final ScrollController horizontalScrollController;
  final ScrollController verticalScrollController;
  final double columnWidth = 34.0;

  const GanttGridWidget(
      {super.key,
      required this.tasks,
      required this.horizontalScrollController,
      required this.verticalScrollController});

  @override
  Widget build(BuildContext context) {
    final double totalWidth = calculateGridWidth();
    final double totalHeight = tasks.length * 35.0;

    return Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 10),
        child: SingleChildScrollView(
          controller: horizontalScrollController,
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            controller: verticalScrollController,
            scrollDirection: Axis.vertical,
            child: SizedBox(
              width: totalWidth,
              height: totalHeight,
              child: Stack(
                children: [
                  buildGrid(totalWidth, totalHeight),
                  ...tasks.asMap().entries.map((entry) {
                    int rowIndex = entry.key;
                    GanttTask task = entry.value;
                    return TaskWidget(
                        task: task,
                        columnWidth: columnWidth,
                        rowIndex: rowIndex);
                  }),
                ],
              ),
            ),
          ),
        ));
  }

  double calculateGridWidth() {
    final DateTime now = DateTime.now();
    final int year = now.year;

    int totalDays = 0;
    for (int month = 1; month <= 12; month++) {
      totalDays += DateUtils.getDaysInMonth(year, month);
    }

    return totalDays * columnWidth;
  }

  Widget buildGrid(double totalWidth, double totalHeight) {
    final Paint gridPaint = Paint()
      ..color = Colors.cyan
      ..strokeWidth = 1.0;

    final Paint weekendPaint = Paint()
      ..color = Colors.red.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    return CustomPaint(
      size: Size(totalWidth, totalHeight),
      painter: GridPainter(
          columnWidth: columnWidth,
          weekendPaint: weekendPaint,
          gridPaint: gridPaint),
    );
  }
}

class GridPainter extends CustomPainter {
  final double columnWidth;
  final Paint weekendPaint;
  final Paint gridPaint;

  GridPainter(
      {required this.columnWidth,
      required this.weekendPaint,
      required this.gridPaint});

  @override
  void paint(Canvas canvas, Size size) {
    for (double x = 0; x < size.width; x += columnWidth) {
      DateTime date = DateTime(DateTime.now().year)
          .add(Duration(days: (x / columnWidth).round()));
      if (date.weekday == DateTime.saturday ||
          date.weekday == DateTime.sunday) {
        canvas.drawRect(
            Rect.fromLTWH(x, 0, columnWidth, size.height), weekendPaint);
      }
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    for (double y = 0; y < size.height; y += 35) {
      canvas.drawLine(Offset(0, y + -5), Offset(size.width, y), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
