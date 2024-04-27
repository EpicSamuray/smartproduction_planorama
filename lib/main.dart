import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));

  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(1200, 750);
    win.minSize = const Size(601, 621);
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "Planorama";
    win.show();
  });
}
