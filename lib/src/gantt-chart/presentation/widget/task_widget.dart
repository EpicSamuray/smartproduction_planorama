import 'package:flutter/material.dart';

import '../../domain/model/gantt_task.dart';

class TaskWidget extends StatelessWidget {
  final GanttTask task;
  final double columnWidth;
  final int rowIndex;

  const TaskWidget({
    super.key,
    required this.task,
    required this.columnWidth,
    required this.rowIndex,
  });

  @override
  Widget build(BuildContext context) {
    // Berechne die Start- und Endtage im Jahr
    final int startDay =
        task.start.difference(DateTime(task.start.year, 1, 1)).inDays;
    final int endDay = task.calculatedEnd
        .difference(DateTime(task.calculatedEnd.year, 1, 1))
        .inDays;

    final double left = startDay * columnWidth;
    final double width = (endDay - startDay + 1) * columnWidth;
    final double top = rowIndex * 35;

    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: width,
        height: 30,
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
