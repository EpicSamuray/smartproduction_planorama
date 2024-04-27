import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:smartproduction_planorama/view/widget/windowsBar.dart';

import 'Login.dart';


class WindowsFrame extends StatelessWidget {
  const WindowsFrame ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WindowBorder(
            color: Colors.amber,
            width: 1,
            child: const Stack(
              children: [
                LoginScreen(),
                WindowsBar(),
              ],
            )
        )
    );
  }
}
