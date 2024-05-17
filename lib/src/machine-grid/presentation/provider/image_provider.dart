import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartproduction_planorama/src/machine-grid/data/dto/new/machine_image_dto.dart';

import '../../../../common/constants.dart';
import '../../../../common/logging.dart';
import '../../../../providers/machine.provider.dart';
import '../../../../providers/storage.provider.dart';
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
      log.logInfo('FileId: $fileId, ImagesLocationPath: $imagesLocationPath');
      try {
        await ref.read(storageRepositoryProvider).downloadFile(
            bucketId: AppwriteBucket.machineImages.value, fileId: fileId);
        var machineImageLocationDto = MachineImageDto(
            imageId: fileId,
            imageLocalPath: imagesLocationPath,
            machineId: d.$id);
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

final imageDeleterProvider =
    FutureProvider.family.autoDispose<void, String>((ref, data) async {
  log.logInfo('Starting image delete');

  final machineNotifier = ref.read(machineProvider.notifier);
  final List<MachineImageDto> test =
      await machineNotifier.searchMachineCardDto('imageId', data);

  log.logDebug('Test: ${test.length}');

  final fileId = test.first.imageId;
  final imagesLocation = test.first.imageLocalPath;

  log.logInfo('FileId: $fileId, ImagesLocationPath: $imagesLocation');

  try {
    ref
        .read(listMachineWithQueryDbProvider({
      'query': [
        Query.equal("fileId", [fileId])
      ],
      'collectionId': AppwriteCollections.machineRessource.value,
    }).future)
        .then((value) {
      Future.wait([
        ref.read(deleteMachineDbProvider(value.documents.first.$id).future),
        ref.read(storageRepositoryProvider).deleteFile(
            bucketId: AppwriteBucket.machineImages.value, fileId: fileId),
      ]);
    });
    log.logInfo('Image deleted for machine: $fileId');
  } catch (e) {
    log.logError('Error deleting image for machine $fileId: $e');
  }
});

/*
  try {
    await ref.read(storageRepositoryProvider).deleteFile(
        bucketId: AppwriteBucket.machineImages.value, fileId: fileId);
    machineNotifier.removeMachineCardDto(MachineImageLocationDto(
      fileId: fileId,
      imagesLocationPath: imagesLocationPath,
    ));
    log.logInfo('Image deleted for machine: $fileId');
  } catch (e) {
    log.logError('Error deleting image for machine $fileId: $e');
  }

 */
