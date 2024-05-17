import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smartproduction_planorama/common/logging.dart';
import 'package:smartproduction_planorama/src/machine-grid/data/dto/new/machine_image_dto.dart';

import 'app.dart';

final Logging log = Logging('main.dart');

Future<void> main() async {
  debugPaintSizeEnabled = false;
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MachineImageDtoAdapter());
  if (kDebugMode) {
    log.logDebug('Deleting Hive Box');
    await Hive.deleteBoxFromDisk('machineCardDtoBox');
  }
  runApp(ProviderScope(observers: [ProvidersLogger()], child: const MyApp()));

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
