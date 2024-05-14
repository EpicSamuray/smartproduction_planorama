import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/constants.dart';
import '../../../../common/logging.dart';
import '../../../../providers/machine.provider.dart';
import '../../../../providers/storage.provider.dart';
import '../../data/dto/local/machine_image_location_dto.dart';
import '../../data/repo/machine_repository.dart';

final Logging log = Logging('image_provider.dart');

final imageUpdateProvider = FutureProvider.autoDispose<void>((ref) async {
  log.logInfo('Starting image update');

  final machineNotifier = ref.read(machineProvider.notifier);
  final documentList = await ref.read(
      listMachineDbProvider(AppwriteCollections.machineRessource.value).future);

  if (documentList.documents.isNotEmpty) {
    for (Document d in documentList.documents) {
      final fileId = d.data['fileId'];
      final imagesLocationPath = d.data['imagesLocationPath'];

      try {
        await ref.read(storageRepositoryProvider).downloadFile(
            bucketId: AppwriteBucket.machineImages.value, fileId: fileId);
        var machineImageLocationDto = MachineImageLocationDto(
          fileId: fileId,
          imagesLocationPath: imagesLocationPath,
        );
        machineNotifier.addMachineCardDto(machineImageLocationDto);
        log.logInfo('Image updated for machine: $fileId');
      } catch (e) {
        log.logError(
            'Error downloading or updating image for machine $fileId: $e');
      }
    }
  } else {
    log.logInfo('No documents found to update images.');
  }
});
