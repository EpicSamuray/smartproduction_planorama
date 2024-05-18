import 'package:flutter/material.dart';
import 'package:smartproduction_planorama/common/constants.dart';
import 'package:smartproduction_planorama/shared/widget/neumorphism/neumorphism_button_widget.dart';

class GanttTaskList extends StatelessWidget {
  final ScrollController scrollController;
  final double rowHeight = 35.0;

  const GanttTaskList({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      controller: scrollController,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding:
              const EdgeInsets.only(bottom: 5, top: 5, left: 10, right: 10),
          child: NeumorphismButtonWidget(
            height: rowHeight - 10, // Adjust height to fit within row height
            color: HexColors.primaryColor.shade900,
            onPressed: () {},
            borderRadius: 15,
            blur: NeumorphismConstants.blur,
            distance: NeumorphismConstants.distance,
            child: const Center(
              child: Text(
                'ID | operation description',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
