import 'package:flutter/material.dart';
import 'package:smartproduction_planorama/viewModels/Login.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planorama',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.black45,
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}