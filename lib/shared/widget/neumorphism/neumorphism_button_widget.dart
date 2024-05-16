import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:smartproduction_planorama/common/constants.dart';

class NeumorphismButtonWidget extends StatefulWidget {
  final Widget? title;
  final Widget? child;
  final VoidCallback onPressed;
  final bool? isActivated;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Icon? icon;
  final bool? onlyIcon;
  final double blur;
  final double distance;
  final Color color;

  const NeumorphismButtonWidget(
      {super.key,
      this.title,
      required this.onPressed,
      this.isActivated = false,
      this.width,
      this.height,
      this.borderRadius,
      this.icon,
      this.onlyIcon,
      required this.blur,
      required this.distance,
      required this.color,
      this.child});

  @override
  State<NeumorphismButtonWidget> createState() =>
      _NeumorphismButtonWidgetState();
}

class _NeumorphismButtonWidgetState extends State<NeumorphismButtonWidget> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
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
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
              color: widget.color,
              boxShadow: [
                BoxShadow(
                  blurRadius: widget.blur,
                  inset: isPressed || widget.isActivated!,
                  offset: Offset(-widget.distance, -widget.distance),
                  color: HexColors.whiteShadow.shade900,
                ),
                BoxShadow(
                  blurRadius: widget.blur,
                  inset: isPressed || widget.isActivated!,
                  offset: Offset(widget.distance, widget.distance),
                  color: HexColors.blackShadow.shade900,
                ),
              ],
            ),
            child: SizedBox(
              height: widget.height,
              width: widget.width,
              child: Transform.scale(
                  scale: isPressed || widget.isActivated! ? 0.97 : 1,
                  child: widget.child != null
                      ? widget.child ?? const Text('No Child Provided')
                      : widget.onlyIcon ?? false
                          ? widget.icon ?? const Icon(Icons.error)
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(width: 30),
                                widget.icon ?? const Icon(Icons.error),
                                const SizedBox(width: 10),
                                widget.title ?? const Text('No Title Provided'),
                              ],
                            )),
            )));
  }
}
