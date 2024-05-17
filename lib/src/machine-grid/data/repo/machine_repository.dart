import 'dart:io' as dartio;

import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartproduction_planorama/common/constants.dart';
import 'package:smartproduction_planorama/src/machine-grid/data/dto/new/machine_dto.dart';
import 'package:smartproduction_planorama/src/machine-grid/domain/usecase/local_storage_access.dart';
import 'package:smartproduction_planorama/src/machine-grid/domain/usecase/machine_mapper.dart';

import '../../../../common/logging.dart';
import '../../../../core/network/data/repo/databases_repository.dart';
import '../../../../providers/storage.provider.dart';
import '../../domain/model/machine_model.dart';

final Logging log = Logging('machine_repository.dart');

final createMachineProvider =
    FutureProvider.family<bool, Machine>((ref, data) async {
  try {
    final repo = ref.read(databaseRepositoryProvider);
    final storage = ref.read(storageRepositoryProvider);
    final MachineDTO machineDto = MachineMapper.toMachineDTO(data);
    final dartio.File imageFile = await ref
        .read(fileServiceProvider)
        .readFile(fileName: data.imageId ?? '', mimeType: 'png');

    final results = await Future.wait([
      repo.createDocument(
        collectionId: AppwriteCollections.machineRessource.value,
        data: machineDto,
      ),
      storage.uploadFile(
        fileName: data.name,
        bucketId: AppwriteBucket.machineImages.value,
        file: await imageFile.readAsBytes(),
        fileId: data.imageId!,
      ),
    ]);

    Document document = results[0] as Document;
    File file = results[1] as File;

    log.logInfo('File uploaded: $file');
    log.logInfo('Document created: ${document.data}');
    return true;
  } catch (e, stack) {
    log.logError('Failed to create machine: $e', stack);
    return false;
  }
});

final deleteMachineDbProvider =
    FutureProvider.family<Document, String>((ref, documentId) {
  final repo = ref.read(databaseRepositoryProvider);
  return repo.deleteDocument(
    collectionId: AppwriteCollections.machineRessource.value,
    documentId: documentId,
  );
});

final getMachineDbProvider =
    FutureProvider.family<Document, Map<String, dynamic>>((ref, metaDocument) {
  final repo = ref.read(databaseRepositoryProvider);
  final query = metaDocument['query'] as List<String>;
  final documentId = metaDocument['documentId'] as String;
  return repo.getDocument(
    collectionId: AppwriteCollections.machineRessource.value,
    documentId: documentId,
    query: query,
  );
});

final listMachineDbProvider = FutureProvider.family
    .autoDispose<DocumentList, String>((ref, collectionId) {
  final repo = ref.read(databaseRepositoryProvider);
  return repo.listDocument(collectionId: collectionId);
});

final listMachineWithQueryDbProvider =
    FutureProvider.family<DocumentList, Map<String, dynamic>>(
        (ref, metaCollection) {
  final repo = ref.read(databaseRepositoryProvider);
  final query = metaCollection['query'] as List<String>;
  final collectionId = metaCollection['collectionId'] as String;
  return repo.listDocument(collectionId: collectionId, query: query);
});

final updateMachineDbProvider =
    FutureProvider.family<Document, Map<String, dynamic>>((ref, tupleInfo) {
  final repo = ref.read(databaseRepositoryProvider);
  final data = tupleInfo['data'];
  final documentId = tupleInfo['documentId'];
  return repo.updateDocument(
    collectionId: AppwriteCollections.machineRessource.value,
    documentId: documentId,
    data: data,
  );
});
