import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smartproduction_planorama/common/constants.dart';
import 'package:smartproduction_planorama/shared/widget/neumorphism/neumorphism_container_widget.dart';

class MachineCardView extends StatefulWidget {
  final String? imageLocalPath;
  final bool? isAddCard;

  const MachineCardView({super.key, this.imageLocalPath, this.isAddCard});

  @override
  State<MachineCardView> createState() => _MachineCardViewState();
}

class _MachineCardViewState extends State<MachineCardView> {
  @override
  Widget build(BuildContext context) {
    return widget.isAddCard ?? false
        ? NeumorphismContainerWidget(
            distance: 5,
            blur: 10,
            borderRadius: 20,
            child: Center(
              child: Icon(
                Icons.add,
                color: HexColors.tertiaryColor.shade900,
                size: MediaQuery.of(context).size.width * 0.06,
              ),
            ))
        : NeumorphismContainerWidget(
            distance: 4,
            blur: 10,
            borderRadius: 10,
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
                            textScaler: TextScaler.linear(
                                ScaleSize.scaleWidth(context)),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'CNC | OG13',
                            textScaler: TextScaler.linear(
                                ScaleSize.scaleWidth(context)),
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
                                textScaler: TextScaler.linear(
                                    ScaleSize.scaleWidth(context)),
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
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                      child: LinearProgressIndicator(
                                        borderRadius: BorderRadius.circular(10),
                                        value: 0.5,
                                        backgroundColor:
                                            HexColors.secondColor.shade900,
                                        valueColor: AlwaysStoppedAnimation<
                                                Color>(
                                            HexColors.tertiaryColor.shade900),
                                      ))),
                              Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '50%',
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
