import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/client.provider.dart';

final storageServiceProviders = Provider<StorageService>((ref) {
  return StorageService(ref.read(clientProvider));
});

class StorageService {
  final Client _client;

  StorageService(this._client);

  Storage get storage => Storage(_client);

  Future<FileList> listFiles(
      {required String bucketId,
      List<String>? query,
      String? searchString}) async {
    try {
      return storage.listFiles(
        bucketId: bucketId,
        search: searchString,
        queries: query,
      );
    } on AppwriteException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<File> createFile(
      {required String bucketId,
      required String fileId,
      required InputFile fileData,
      List<String>? permission}) async {
    try {
      return storage.createFile(
        bucketId: bucketId,
        fileId: fileId,
        file: fileData,
        permissions: permission,
      );
    } on AppwriteException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<File> getFile(
      {required String fileId, required String bucketId}) async {
    try {
      return storage.getFile(fileId: fileId, bucketId: bucketId);
    } on AppwriteException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future getFileDownload({required String bucketId, required String fileId}) {
    try {
      return storage.getFileDownload(bucketId: bucketId, fileId: fileId);
    } on AppwriteException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future getFilePreview() {
    //TODO: Implement this
    throw UnimplementedError();
  }

  Future getFileView() {
    //TODO: Implement this
    throw UnimplementedError();
  }

  Future<File> updateFile(
      {required String bucketId,
      required String fileId,
      String? name,
      List<String>? permissions}) {
    try {
      return storage.updateFile(
        bucketId: bucketId,
        fileId: fileId,
        name: name,
        permissions: permissions,
      );
    } on AppwriteException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future deleteFile({required String bucketId, required String fileId}) {
    try {
      return storage.deleteFile(bucketId: bucketId, fileId: fileId);
    } on AppwriteException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
