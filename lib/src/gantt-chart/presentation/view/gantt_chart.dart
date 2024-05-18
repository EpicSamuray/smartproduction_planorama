import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

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
  late LinkedScrollControllerGroup _controllers;
  late LinkedScrollControllerGroup _controllers2;
  late ScrollController _scrollController4;
  late ScrollController _scrollController1;
  late ScrollController _scrollController2;
  late ScrollController _scrollController3;

  @override
  void initState() {
    super.initState();
    _controllers = LinkedScrollControllerGroup();
    _scrollController1 = _controllers.addAndGet();
    _scrollController2 = _controllers.addAndGet();
    _controllers2 = LinkedScrollControllerGroup();
    _scrollController3 = _controllers2.addAndGet();
    _scrollController4 = _controllers2.addAndGet();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final height = MediaQuery.of(context).size.height - 200;
    List<GanttTask> tasks = [
      GanttTask(
        start: DateTime(2024, 01, 26),
        end: DateTime(2024, 06, 16 + 1),
        label: '$height',
        duration: null,
      ),
    ];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: 300,
          height: height,
          child: GanttTaskList(
            scrollController: _scrollController4,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            children: [
              DateSelectorWidget(scrollController: _scrollController1),
              const SizedBox(height: 20),
              SizedBox(
                height: height,
                child: GanttGridWidget(
                    horizontalScrollController: _scrollController2,
                    verticalScrollController: _scrollController3,
                    tasks: tasks),
              ),
            ],
          ),
        )
      ],
    );
  }
}
