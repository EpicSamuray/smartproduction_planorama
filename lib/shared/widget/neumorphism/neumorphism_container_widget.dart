import 'package:flutter/material.dart';

import '../../../common/constants.dart';

class NeumorphismContainerWidget extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double distance;
  final double blur;
  final bool? inset;
  const NeumorphismContainerWidget(
      {super.key,
      required this.child,
      this.borderRadius,
      this.width,
      this.height,
      this.inset = false,
      required this.distance,
      required this.blur});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        color: HexColors.primaryColor.shade900,
        boxShadow: [
          BoxShadow(
            blurRadius: blur,
            offset: inset!
                ? Offset(distance, distance)
                : Offset(-distance, -distance),
            color: Colors.white.withOpacity(0.15),
          ),
          BoxShadow(
            blurRadius: blur,
            offset: inset!
                ? Offset(-distance, -distance)
                : Offset(distance, distance),
            color: Colors.black.withOpacity(0.5),
          ),
        ],
      ),
      child: child,
    );
  }
}
