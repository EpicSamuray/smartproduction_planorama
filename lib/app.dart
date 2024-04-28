import 'package:flutter/material.dart';
import 'package:smartproduction_planorama/common/themes.dart';
import 'package:smartproduction_planorama/view/windowsFrame.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planorama',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.mainTheme,
      home: WindowsFrame(),
    );
  }
}