import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartproduction_planorama/src/machine-grid/presentation/widget/image_preview_widget.dart';
import 'package:smartproduction_planorama/src/machine-grid/presentation/widget/upload_image_button_widget.dart';

import '../provider/file_picker_provider.dart';

class FilePickerWidget extends ConsumerWidget {
  const FilePickerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (context, ref, child) {
      return ref.watch(filePickerProvider).when(
            data: (Map<String, dynamic> data) {
              if (data['file'] == null) {
                return const UploadImageButton();
              } else {
                return ImagePreviewWidget(data: data);
              }
            },
            error: (Object error, StackTrace stackTrace) =>
                Text('Error: $error'),
            loading: () => const CircularProgressIndicator(),
          );
    });
  }
}
