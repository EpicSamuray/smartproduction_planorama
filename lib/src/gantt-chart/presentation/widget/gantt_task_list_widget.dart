import 'package:flutter/material.dart';
import 'package:smartproduction_planorama/common/constants.dart';
import 'package:smartproduction_planorama/shared/widget/neumorphism/neumorphism_container_widget.dart';

class GanttTaskList extends StatelessWidget {
  const GanttTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return NeumorphismContainerWidget(
        height: double.infinity,
        borderRadius: 20,
        distance: NeumorphismConstants.distance,
        blur: NeumorphismConstants.blur,
        color: HexColors.primaryColor.shade900,
        inset: true,
        child: Container());
  }
}
