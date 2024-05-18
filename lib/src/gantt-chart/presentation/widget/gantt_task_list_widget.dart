import 'package:flutter/material.dart';
import 'package:smartproduction_planorama/common/constants.dart';
import 'package:smartproduction_planorama/shared/widget/neumorphism/neumorphism_button_widget.dart';

class GanttTaskList extends StatelessWidget {
  final ScrollController scrollController;
  const GanttTaskList({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      const SizedBox(height: 98),
      SizedBox(
        height: MediaQuery.of(context).size.height - 270,
        child: ListView.builder(
          itemCount: 40,
          controller: scrollController,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding:
                  const EdgeInsets.only(bottom: 5, top: 5, left: 10, right: 10),
              child: NeumorphismButtonWidget(
                height: 25,
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
        ),
      ),
    ]);
  }
}
