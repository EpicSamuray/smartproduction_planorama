import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:smartproduction_planorama/common/constants.dart';

import '../../common/logging.dart';

final log = Logging('menu.button.widget.dart');

class MenuButtonWidget extends StatefulWidget {
  final Widget? title;
  final VoidCallback onPressed;
  final bool isActivated;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Icon icon;
  final bool? isOutside;
  final bool? onlyIcon;
  final double blur;
  final double distance;

  const MenuButtonWidget({
    super.key,
    this.title,
    required this.onPressed,
    required this.icon,
    this.isActivated = false,
    this.width = 200,
    this.height = 50,
    this.borderRadius,
    this.isOutside = false,
    this.onlyIcon = false,
    required this.blur,
    required this.distance,
  });

  @override
  State<MenuButtonWidget> createState() => _MenuButtonWidgetState();
}

class _MenuButtonWidgetState extends State<MenuButtonWidget> {
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
          color: HexColors.primaryColor.shade900,
          boxShadow: [
            BoxShadow(
              blurRadius: widget.blur,
              inset: isPressed || widget.isActivated,
              offset: Offset(-widget.distance, -widget.distance),
              color: HexColors.whiteShadow.shade900,
            ),
            BoxShadow(
              blurRadius: widget.blur,
              inset: isPressed || widget.isActivated,
              offset: Offset(widget.distance, widget.distance),
              color: HexColors.blackShadow.shade900,
            ),
          ],
        ),
        child: SizedBox(
            height: widget.height,
            width: widget.width,
            child: widget.onlyIcon!
                ? widget.icon
                : Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: widget.icon,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: widget.title,
                      ),
                    ],
                  )),
      ),
    );
  }
}
