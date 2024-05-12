import 'dart:io';
import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as AppwriteModels;
import 'package:smartproduction_planorama/common/logging.dart';
import 'package:path_provider/path_provider.dart';

final Logging log = Logging('storage.service.dart');

class StorageService {
  final Storage _staorage;

  StorageService(this._staorage);


  Future<Map<String, dynamic>> downloadImages(String bucketId, String fileId) async {
    try {
      Uint8List result = await _staorage.getFileDownload(
        fileId: fileId,
        bucketId: bucketId,
      );

      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/$fileId.jpg';

      final file = File(path);
      await file.writeAsBytes(result);

      log.logInfo('File downloaded to $path');
      return {
        'isDownloaded': true,
        'path': path,
      };
    } on AppwriteException catch (e) {
      log.logError('Error downloading file: ${e.message}');
      return {
        'isDownloaded': false,
        'path': '',
      };
    } catch (e) {
      log.logError('Error downloading file: $e');
      return {
        'isDownloaded': false,
        'path': '',
      };
    }
  }

  Future<AppwriteModels.File> uploadImages(String fileName,String bucketId, Uint8List file) async {
    try {
      return await _staorage.createFile(
        bucketId: bucketId,
        fileId: ID.unique(),
        file: InputFile.fromBytes(bytes: file, filename: fileName),
        permissions: ['read("any")'],
      );
    } on AppwriteException catch (e) {
      log.logError('Error uploading file: ${e.message}');
      rethrow;
    } catch (e) {
      log.logError('Error uploading file: $e');
      rethrow;
    }
  }
}