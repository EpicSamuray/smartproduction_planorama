import 'package:flutter/material.dart';

import '../../domain/model/gantt_task.dart';

class TaskWidget extends StatelessWidget {
  final GanttTask task;
  final double columnWidth;
  final double rowHeight;
  final int rowIndex;

  const TaskWidget({
    super.key,
    required this.task,
    required this.columnWidth,
    required this.rowHeight,
    required this.rowIndex,
  });

  @override
  Widget build(BuildContext context) {
    final int startDay =
        task.start.difference(DateTime(task.start.year, 1, 1)).inDays;
    final int endDay = task.calculatedEnd
        .difference(DateTime(task.calculatedEnd.year, 1, 1))
        .inDays;

    final double left = startDay * columnWidth;
    final double width = (endDay - startDay + 1) * columnWidth;
    final double top = rowIndex * rowHeight;

    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: width,
        height: rowHeight - 5, // Adjust height to fit within row height
        decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            task.label,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
