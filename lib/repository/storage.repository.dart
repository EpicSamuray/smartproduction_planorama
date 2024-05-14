import 'dart:typed_data';

import 'package:appwrite/models.dart';
import 'package:smartproduction_planorama/src/machine-grid/data/dto/local/machine_image_location_dto.dart';
import 'package:smartproduction_planorama/providers/machine.provider.dart';

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
          MachineImageLocationDto machineCardDto = MachineImageLocationDto(
            imagesLocationPath: path,
            fileId: fileId,
          );
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
      File uploadedFile = await _storageService.uploadImages(
        fileName: fileName,
        bucketId: bucketId,
        file: file,
        fileId: fileId,
      );
      log.logInfo('File uploaded: ${uploadedFile.name}');
      return uploadedFile;
    } catch (e) {
      log.logError('Error uploading file: $e');
      rethrow;
    }
  }
}
