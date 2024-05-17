import 'package:flutter/material.dart';

import '../../domain/model/gantt_task.dart';

class GanttGridWidget extends StatelessWidget {
  final List<GanttTask> tasks;
  final ScrollController scrollController;

  const GanttGridWidget({required this.tasks, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: CustomPaint(
          size: Size(MediaQuery.of(context).size.width * 2, 300),
          painter: GanttChartPainter(tasks: tasks),
        ),
      ),
    );
  }
}

class GanttChartPainter extends CustomPainter {
  final List<GanttTask> tasks;

  GanttChartPainter({required this.tasks});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint gridPaint = Paint()
      ..color = Colors.cyan
      ..strokeWidth = 1.0;

    final Paint barPaint = Paint()
      ..color = Colors.cyan
      ..style = PaintingStyle.fill;

    final Paint weekendPaint = Paint()
      ..color = Colors.red.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final double columnWidth = size.width / 31; // Assuming one month view

    // Draw grid lines
    for (int i = 0; i <= 31; i++) {
      double x = i * columnWidth;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    // Draw weekend highlights
    for (int i = 0; i < 31; i++) {
      DateTime date =
          DateTime(DateTime.now().year, DateTime.now().month, i + 1);
      if (date.weekday == DateTime.saturday ||
          date.weekday == DateTime.sunday) {
        double x = i * columnWidth;
        canvas.drawRect(
            Rect.fromLTWH(x, 0, columnWidth, size.height), weekendPaint);
      }
    }

    // Draw tasks
    for (var task in tasks) {
      int startDayOfMonth = task.start.day;
      int endDayOfMonth = task.end.day;

      double left = (startDayOfMonth - 1) * columnWidth;
      double right = endDayOfMonth * columnWidth;
      double top = 100.0;
      double bottom = 150.0;

      Rect barRect = Rect.fromLTRB(left, top, right, bottom);
      canvas.drawRect(barRect, barPaint);

      // Draw label
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: task.label,
          style: TextStyle(color: Colors.cyan, fontSize: 12),
        ),
      );
      textPainter.layout(minWidth: 0, maxWidth: right - left);
      textPainter.paint(canvas, Offset(left + 4, top + 4));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
