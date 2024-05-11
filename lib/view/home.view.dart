import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartproduction_planorama/common/constants.dart';
import 'package:smartproduction_planorama/repository/storage.repository.dart';

import '../providers/storage.provider.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          ref.read(storageRepositoryProvider).downloadFile(AppwriteConstant.collectionID, '663fea8f002f2f898b4a');
        },
        child: const Text('Go back!'),
      ),
    );
  }
}
