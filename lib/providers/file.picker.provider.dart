import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/logging.dart';

final Logging log = Logging('file.picker.provider.dart');

final filePickerProvider = StateNotifierProvider<FilePickerNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  return FilePickerNotifier();
});

class FilePickerNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  FilePickerNotifier() : super(const AsyncValue.data({
    'file': null,
    'fileName': null,
  }));

  void pickFile() async {
    state = const AsyncValue.data({
      'file': null,
      'fileName': null,
      'filePath': null,
    });
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(withData: true);
      if (result != null) {
        log.logDebug('File picked: ${result.files.single.name} : ${result.files.single.path} : ${result.files.single.bytes}');
        state = AsyncValue.data({
          'file': result.files.single.bytes,
          'fileName': result.files.single.name,
          'filePath': result.files.single.path,
        });
      }
    } catch (e, stackTrace) {
      log.logError(e.toString(), stackTrace);
      state = AsyncValue.error(e, stackTrace);
    }
  }

  void clearFile() {
    state = const AsyncValue.data({
      'file': null,
      'fileName': null,
      'filePath': null,
    });
  }
}