import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartproduction_planorama/common/constants.dart';
import 'package:smartproduction_planorama/src/machine-grid/data/dto/remote/machine_created_dto.dart';
import '../../../../common/logging.dart';
import '../../../../core/network/data/repo/databases_repository.dart';
import '../../../../providers/storage.provider.dart';
import '../dto/remote/machine_upload_dto.dart';

final Logging log = Logging('machine_repository.dart');

final createMachineDbProvider = FutureProvider.family<MachineCreatedDto, MachineUploadDto>((ref, data) {
  final repo = ref.read(databaseRepositoryProvider);
  final storage = ref.read(storageRepositoryProvider);

  Future<Document> document = repo.createDocument(
    collectionId: AppwriteCollections.machineRessource.value,
    data: data.metaMachine,
  );

  Future<File> file = storage.uploadFile(
    fileName: data.image.imageName,
    bucketId: AppwriteBucket.machineImages.value,
    file: data.image.image,
    fileId: data.metaMachine.fileId,
  );

  MachineCreatedDto machineCreatedDto = MachineCreatedDto(
    document: document,
    file: file,
  );
  return machineCreatedDto;
});

final deleteMachineDbProvider = FutureProvider.family<Document, String>((ref, documentId) {
  final repo = ref.read(databaseRepositoryProvider);
  return repo.deleteDocument(
    collectionId: AppwriteCollections.machineRessource.value,
    documentId: documentId,
  );
});

final getMachineDbProvider = FutureProvider.family<Document, String>((ref, documentId) {
  final repo = ref.read(databaseRepositoryProvider);
  return repo.getDocument(
    collectionId: AppwriteCollections.machineRessource.value,
    documentId: documentId,
  );
});

final listMachineDbProvider = FutureProvider.family<DocumentList, String>((ref, collectionId) {
  final repo = ref.read(databaseRepositoryProvider);
  return repo.listDocument(collectionId);
});

final updateMachineDbProvider = FutureProvider.family<Document, Map<String, dynamic>>((ref, tupleInfo) {
  final repo = ref.read(databaseRepositoryProvider);
  final data = tupleInfo['data'];
  final documentId = tupleInfo['documentId'];
  return repo.updateDocument(
    collectionId: AppwriteCollections.machineRessource.value,
    documentId: documentId,
    data: data,
  );
});