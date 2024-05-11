import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gantt_chart/gantt_chart.dart';
import 'package:smartproduction_planorama/view/widget/machine.card.widget.dart';
import 'package:smartproduction_planorama/view/widget/neumorphism.container.widget.dart';

class MachinePlanningView extends StatefulWidget {
  const MachinePlanningView({super.key});

  @override
  State<MachinePlanningView> createState() => _MachinePlanningViewState();
}

class _MachinePlanningViewState extends State<MachinePlanningView> {
  final scrollController = ScrollController();

  double dayWidth = 30;
  bool showDaysRow = true;
  bool showStickyArea = true;
  bool customStickyArea = false;
  bool customWeekHeader = false;
  bool customDayHeader = false;

  void onZoomIn() {
    setState(() {
      dayWidth += 5;
    });
  }

  void onZoomOut() {
    if (dayWidth <= 10) return;
    setState(() {
      dayWidth -= 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: Padding(
      padding: EdgeInsets.all(30),
      child: NeumorphismContainerWidget(
        distance: 3,
        blur: 3,
        borderRadius: 15,
        child: Padding(
            padding: EdgeInsets.all(20),
            child: GridView.builder(
              itemCount: 30,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(20),
                  child: MachineCardWidget(),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.8,
              ),
            ),
        ),
      ),
        ),
    );
  }
}
