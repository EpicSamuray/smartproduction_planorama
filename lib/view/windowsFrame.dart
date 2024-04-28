import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartproduction_planorama/view/Login.dart';
import 'package:smartproduction_planorama/view/dashboard.dart';
import 'package:smartproduction_planorama/view/widget/windowsBar.dart';

import '../viewModels/authProvider.dart';


class WindowsFrame extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: WindowBorder(
        color: Colors.amber,
        width: 1,
        child: Stack(
          children: [
            const DashboardScreen(),
            const WindowsBar(),
          ],
        ),
      ),
    );
  }
}
