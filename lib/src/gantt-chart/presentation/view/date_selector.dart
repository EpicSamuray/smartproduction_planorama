import 'package:flutter/material.dart';
import 'package:smartproduction_planorama/common/constants.dart';
import 'package:smartproduction_planorama/shared/widget/neumorphism/neumorphism_container_widget.dart';

class TestContainer extends StatefulWidget {
  const TestContainer({super.key});

  @override
  State<TestContainer> createState() => _DateSelectorWidgetState();
}

class _DateSelectorWidgetState extends State<TestContainer> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GanttChartWidget(
          tasks: [
            GanttTask(start: 0, end: 2, label: 'ID\noperation description'),
            GanttTask(start: 4, end: 6, label: 'ID\noperation description'),
            GanttTask(start: 8, end: 9, label: 'ID\noperation description'),
          ],
        ),
      ],
    );
  }
}

class GanttChartWidget extends StatelessWidget {
  final List<GanttTask> tasks;

  GanttChartWidget({required this.tasks});

  @override
  Widget build(BuildContext context) {
    return NeumorphismContainerWidget(
      distance: NeumorphismConstants.distance,
      blur: NeumorphismConstants.blur,
      color: HexColors.primaryColor.shade900,
      inset: true,
      borderRadius: 20,
      child: CustomPaint(
        size: Size(MediaQuery.of(context).size.width, 300),
        painter: GanttChartPainter(tasks: tasks),
      ),
    );
  }
}

class GanttTask {
  final int start;
  final int end;
  final String label;

  GanttTask({required this.start, required this.end, required this.label});
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

    final double columnWidth = size.width / 20;

    // Draw grid lines
    for (int i = 0; i <= 20; i++) {
      double x = i * columnWidth;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    // Draw weekend highlights
    for (int i = 0; i < 20; i++) {
      if (i % 7 == 5 || i % 7 == 6) {
        // 5 = Saturday, 6 = Sunday
        double x = i * columnWidth;
        canvas.drawRect(
            Rect.fromLTWH(x, 0, columnWidth, size.height), weekendPaint);
      }
    }

    // Draw tasks
    for (var task in tasks) {
      double left = task.start * columnWidth;
      double right = task.end * columnWidth + columnWidth;
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
        textDirection: TextDirection.ltr,
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
