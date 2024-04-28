import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:smartproduction_planorama/view/widget/windowsButtons.dart';

class WindowsBar extends StatelessWidget {
  const WindowsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30 ,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: WindowTitleBarBox(child: MoveWindow(),)),
            const WindowsButtons()
          ],
        )
    );
  }
}
