import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/file_picker_provider.dart';

class ImagePreviewWidget extends ConsumerWidget {
  final Map<String, dynamic> data;

  const ImagePreviewWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.memory(data['file'] as Uint8List, width: 200),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => ref.read(filePickerProvider.notifier).pickFile(),
          child: const Text('Change'),
        ),
      ],
    );
  }
}
