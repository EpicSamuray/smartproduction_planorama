import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smartproduction_planorama/common/constants.dart';

import '../../../../shared/widget/neumorphism/neumorphism_container_widget.dart';

class MachineCardWidget extends StatefulWidget {
  final String? filePath;
  final bool? isAddCard;
  final VoidCallback onPressed;
  final double distance;
  final double blur;
  const MachineCardWidget(
      {super.key,
      required this.onPressed,
      required this.distance,
      required this.blur,
      this.filePath,
      this.isAddCard});

  @override
  State<MachineCardWidget> createState() => _MachineCardWidgetState();
}

class _MachineCardWidgetState extends State<MachineCardWidget> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    double distance = isPressed ? -widget.distance : widget.distance;
    double blur = widget.blur;

    return Listener(
      onPointerDown: (event) {
        setState(() {
          isPressed = true;
        });
      },
      onPointerUp: (event) {
        setState(() {
          isPressed = false;
        });
        widget.onPressed();
      },
      child: NeumorphismContainerWidget(
        distance: distance,
        blur: blur,
        borderRadius: 15,
        child: widget.isAddCard ?? false
            ? Icon(
                Icons.add,
                color: HexColors.tertiaryColor.shade900,
                size: 50,
              )
            : Image.file(File(widget.filePath ?? '')),
      ),
    );
  }
}
