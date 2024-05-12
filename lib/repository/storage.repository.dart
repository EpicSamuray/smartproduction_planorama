import 'package:smartproduction_planorama/models/machine.card.dto.dart';
import 'package:smartproduction_planorama/providers/machine.provider.dart';

import '../common/logging.dart';
import '../service/storage.service.dart';

final Logging log = Logging('storage.repository.dart');



class StorageRepository {
  final StorageService _storageService;
  final MachineNotifier _machineProvider;

  StorageRepository(this._storageService, this._machineProvider);

  Future<String> downloadFile(String machineName, String bucketId, String fileId) async {
    bool isDownloaded = false;
    String path = '';
    Map<String, dynamic> result  = await _storageService.downloadImages(bucketId, fileId);

    isDownloaded = result['isDownloaded'];
    path = result['path'];

    if (isDownloaded) {
      MachineCardDto machineCardDto = MachineCardDto(
          imagesLocationPath: path,
          machineName: machineName,
          imageId: fileId
      );
      log.logInfo('File downloaded to $path');
      _machineProvider.addMachineCardDto(machineCardDto);
      return path;
    } else {
      log.logError('Error downloading file');
      return '';
    }
  }
}