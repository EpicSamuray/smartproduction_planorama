import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

final fileServiceProvider = Provider((ref) => LocalStorageAccess());

class LocalStorageAccess {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFile(String fileName, String mimeType) async {
    final path = _localPath;
    return File('$path/$fileName.$mimeType');
  }

  Future<File> writeFile(
      {required String fileName,
      required String mimeType,
      required Uint8List data}) async {
    try {
      final file = await _localFile(fileName, mimeType);
      return file.writeAsBytes(data);
    } catch (e) {
      throw Exception('Error writing file: $e');
    }
  }

  Future<File> readFile(
      {required String fileName, required String mimeType}) async {
    try {
      final file = await _localFile(fileName, mimeType);
      return file;
    } catch (e) {
      throw Exception('Error reading file: $e');
    }
  }

  Future<bool> deleteFile(
      {required String fileName, required String mimeType}) async {
    try {
      final file = await _localFile(fileName, mimeType);
      await file.delete();
      return true;
    } catch (e) {
      throw Exception('Error deleting file: $e');
    }
  }
}
