import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return const Center();
  }
}
