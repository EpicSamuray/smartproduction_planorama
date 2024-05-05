import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:smartproduction_planorama/view/widget/windowsButtons.dart';

class WindowTitleBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const WindowTitleBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: preferredSize.height,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
                child: WindowTitleBarBox(
                    child: MoveWindow(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
            )))),
            const WindowsButtons()
          ],
        )
    );
  }
  
  @override
  Size get preferredSize => const Size(double.infinity, 30);
}
