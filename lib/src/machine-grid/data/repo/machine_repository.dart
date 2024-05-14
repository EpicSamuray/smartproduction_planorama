import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartproduction_planorama/common/constants.dart';
import 'package:smartproduction_planorama/src/machine-grid/data/dto/remote/machine_created_dto.dart';

import '../../../../common/logging.dart';
import '../../../../core/network/data/repo/databases_repository.dart';
import '../../../../providers/storage.provider.dart';
import '../dto/remote/machine_upload_dto.dart';

final Logging log = Logging('machine_repository.dart');

final createMachineDbProvider =
    FutureProvider.family<MachineCreatedDto, MachineUploadDto>(
        (ref, data) async {
  try {
    final repo = ref.read(databaseRepositoryProvider);
    final storage = ref.read(storageRepositoryProvider);

    Document document = await repo.createDocument(
      collectionId: AppwriteCollections.machineRessource.value,
      data: data.metaMachine,
    );

    log.logInfo('Document created: ${document.data}');

    File file = await storage.uploadFile(
      fileName: data.image.imageName,
      bucketId: AppwriteBucket.machineImages.value,
      file: data.image.image,
      fileId: data.metaMachine.fileId,
    );

    log.logInfo('File uploaded: ${file.name}');

    return MachineCreatedDto(
      document: document,
      file: file,
    );
  } catch (e, stack) {
    // Fehlerbehandlung
    log.logError('Failed to create machine: $e', stack);
    throw Exception('Failed to process machine data: $e');
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
