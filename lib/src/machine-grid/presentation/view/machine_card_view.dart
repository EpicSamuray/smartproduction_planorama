import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smartproduction_planorama/common/constants.dart';
import 'package:smartproduction_planorama/shared/widget/neumorphism/neumorphism_button_widget.dart';

class MachineCardView extends StatefulWidget {
  final String? imageLocalPath;
  final bool? isAddCard;
  final double progressInPercent;

  const MachineCardView(
      {super.key,
      this.imageLocalPath,
      this.isAddCard,
      required this.progressInPercent});

  @override
  State<MachineCardView> createState() => _MachineCardViewState();
}

class _MachineCardViewState extends State<MachineCardView> {
  @override
  Widget build(BuildContext context) {
    double progress =
        widget.progressInPercent > 100 ? 100 : widget.progressInPercent;

    return NeumorphismButtonWidget(
      color: HexColors.primaryColor.shade900,
      distance: NeumorphismConstants.distance,
      blur: NeumorphismConstants.blur,
      borderRadius: 10,
      onPressed: () {},
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(10),
                child: AspectRatio(
                  aspectRatio: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(
                      File(widget.imageLocalPath ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TT1800',
                      textScaler:
                          TextScaler.linear(ScaleSize.scaleWidth(context)),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'CNC | OG13',
                      textScaler:
                          TextScaler.linear(ScaleSize.scaleWidth(context)),
                      style: const TextStyle(
                          fontWeight: FontWeight.w100,
                          color: Colors.white,
                          fontSize: 8),
                    )
                  ],
                )),
            AspectRatio(
                aspectRatio: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Auslastung',
                          textScaler:
                              TextScaler.linear(ScaleSize.scaleWidth(context)),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.w100),
                        ),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        FractionallySizedBox(
                            widthFactor: 0.9,
                            child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                                child: LinearProgressIndicator(
                                  borderRadius: BorderRadius.circular(10),
                                  value: progress / 100,
                                  backgroundColor:
                                      HexColors.secondColor.shade900,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      progress <= 69 && progress >= 0
                                          ? Colors.yellow
                                          : progress <= 94 && progress >= 70
                                              ? Colors.green
                                              : Colors.red),
                                ))),
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                              '$progress %',
                              textScaler: TextScaler.linear(
                                  ScaleSize.scaleWidth(context)),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                              ),
                            ))
                      ],
                    ),
                  ],
                ))
          ]),
    );
  }
}

class ScaleSize {
  static double scaleWidth(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}
