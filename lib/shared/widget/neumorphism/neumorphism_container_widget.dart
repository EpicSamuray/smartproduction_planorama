import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class NeumorphismContainerWidget extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double distance;
  final double blur;
  final bool? inset;
  final bool isClickable;
  final VoidCallback? onTap;
  final Color color;

  const NeumorphismContainerWidget({
    super.key,
    required this.child,
    this.borderRadius,
    this.width,
    this.height,
    this.inset = false,
    required this.distance,
    required this.blur,
    this.isClickable = true,
    this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        color: color,
        boxShadow: [
          BoxShadow(
            blurRadius: blur,
            inset: inset ?? false,
            offset: Offset(-distance, -distance),
            color: Colors.white.withOpacity(0.5),
          ),
          BoxShadow(
            blurRadius: blur,
            inset: inset ?? false,
            offset: Offset(distance, distance),
            color: Colors.black.withOpacity(0.5),
          ),
        ],
      ),
      child: isClickable
          ? InkWell(
              onTap: onTap,
              child: child,
            )
          : child,
    );
  }
}
