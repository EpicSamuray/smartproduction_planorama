import 'dart:typed_data';

import 'package:appwrite/models.dart';
import 'package:smartproduction_planorama/providers/machine.provider.dart';
import 'package:smartproduction_planorama/src/machine-grid/data/dto/new/machine_image_dto.dart';

import '../common/logging.dart';
import '../service/storage.service.dart';

final Logging log = Logging('storage.repository.dart');

class StorageRepository {
  final StorageService _storageService;
  final MachineNotifier _machineProvider;

  StorageRepository(this._storageService, this._machineProvider);

  Future<String> downloadFile(
      {required String bucketId, required String fileId}) async {
    bool isDownloaded = false;
    String path = '';

    _machineProvider
        .searchMachineCardDto('imageId', fileId)
        .then((value) async {
      if (value.isEmpty) {
        log.logInfo('File already downloaded');
        Map<String, dynamic> result =
            await _storageService.downloadImages(bucketId, fileId);

        isDownloaded = result['isDownloaded'];
        path = result['path'];

        if (isDownloaded) {
          MachineImageDto machineCardDto = MachineImageDto(
              imageId: fileId, imageLocalPath: path, machineId: '');

          log.logInfo('File downloaded to $path');

          _machineProvider.addMachineCardDto(machineCardDto);

          return path;
        } else {
          log.logError('Error downloading file');
          return '';
        }
      }
    });
    return path;
  }

  Future<File> uploadFile(
      {required String fileId,
      required String fileName,
      required String bucketId,
      required Uint8List file}) async {
    try {
      log.logDebug('Uploading file: $fileName');
      return _storageService.uploadImages(
        fileName: fileName,
        bucketId: bucketId,
        file: file,
        fileId: fileId,
      );
    } catch (e) {
      log.logError('Error uploading file: $e');
      rethrow;
    }
  }

  Future<bool> deleteFile(
      {required String bucketId, required String fileId}) async {
    try {
      log.logDebug('Deleting file: $fileId');
      await _storageService.deleteFile(bucketId: bucketId, fileId: fileId);
      _machineProvider
          .searchMachineCardDto('imageId', fileId)
          .then((value) async {
        if (value.isNotEmpty) {
          MachineImageDto machineCardDto = value.first;
          _machineProvider.removeMachineCardDto(machineCardDto);
          log.logInfo('File deleted: $fileId');
          return true;
        } else {
          log.logError('Error deleting file: $fileId');
          return false;
        }
      });
      return true;
    } catch (e) {
      log.logError('Error deleting file: $e');
      return false;
    }
  }
}
