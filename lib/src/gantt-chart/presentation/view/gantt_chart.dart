import 'package:flutter/material.dart';

import '../../domain/model/gantt_task.dart';
import '../widget/date-selector/date_selector_widget.dart';
import '../widget/gantt_grid_widget.dart';
import '../widget/gantt_task_list_widget.dart';

class GanttChartView extends StatefulWidget {
  const GanttChartView({super.key});

  @override
  State<GanttChartView> createState() => _GanttChartViewState();
}

class _GanttChartViewState extends State<GanttChartView> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    List<GanttTask> tasks = [
      GanttTask(
          start: DateTime(now.year, now.month, 2),
          end: DateTime(now.year, now.month, 4),
          label: 'ID\noperation description'),
      GanttTask(
          start: DateTime(now.year, now.month, 7),
          end: DateTime(now.year, now.month, 9),
          label: 'ID\noperation description'),
      GanttTask(
          start: DateTime(now.year, now.month, 12),
          end: DateTime(now.year, now.month, 14),
          label: 'ID\noperation description'),
    ];

    return Row(
      children: [
        const SizedBox(
          width: 200,
          child: GanttTaskList(),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            children: [
              DateSelectorWidget(scrollController: _scrollController),
              Expanded(
                child: GanttGridWidget(
                    scrollController: _scrollController, tasks: tasks),
              ),
            ],
          ),
        )
      ],
    );
  }
}
