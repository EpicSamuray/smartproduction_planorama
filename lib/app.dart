import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartproduction_planorama/common/router.dart';
import 'package:smartproduction_planorama/common/app.theme.dart';
import 'package:smartproduction_planorama/view/widget/window.titlebar.widget.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      routerConfig: router,
      title: 'Planorama',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.mainTheme,
      builder: (context, child) {
        return Overlay(
          initialEntries: [
            OverlayEntry(builder: (context) => Scaffold(body: child!)),
            OverlayEntry(
              builder: (context) => const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Material(
                  color: Colors.transparent,
                  shadowColor: Colors.transparent,
                  elevation: 4,
                  child: WindowTitleBarWidget(title: 'Planorama'),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
