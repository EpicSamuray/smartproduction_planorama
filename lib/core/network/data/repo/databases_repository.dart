import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartproduction_planorama/common/constants.dart';
import 'package:smartproduction_planorama/common/toJson.abstract.dart';
import 'package:smartproduction_planorama/core/network/data/datasource/databases_service.dart';

final databaseRepositoryProvider = Provider<DatabaseRepository>((ref) {
  return DatabaseRepository(ref.watch(databaseServiceProvider));
});

class DatabaseRepository {
  final DatabasesSerivce _databasesSerivce;

  DatabaseRepository(this._databasesSerivce);

  Future<Document> createDocument(
      {required String collectionId,
      List<String>? permission,
      required JsonSerializable data}) async {
    return _databasesSerivce.createDocument(
      collectionId: collectionId,
      databaseId: AppwriteConstant.databaseID,
      documentId: ID.unique(),
      permissions: permission,
      data: data,
    );
  }

  Future<Document> deleteDocument(
      {required String collectionId, required String documentId}) async {
    return _databasesSerivce.deleteDocument(
      collectionId: collectionId,
      databaseId: AppwriteConstant.databaseID,
      documentId: documentId,
    );
  }

  Future<Document> getDocument(
      {required String collectionId,
      required String documentId,
      List<String>? query}) async {
    return _databasesSerivce.getDocument(
      collectionId: collectionId,
      databaseId: AppwriteConstant.databaseID,
      documentId: collectionId,
      queries: query,
    );
  }

  Future<DocumentList> listDocument(
      {required String collectionId, List<String>? query}) async {
    return _databasesSerivce.listDocument(
      collectionId: collectionId,
      databaseId: AppwriteConstant.databaseID,
      queries: query,
    );
  }

  Future<Document> updateDocument(
      {required String collectionId,
      required String documentId,
      JsonSerializable? data}) async {
    return _databasesSerivce.updateDocument(
      collectionId: collectionId,
      databaseId: AppwriteConstant.databaseID,
      documentId: documentId,
      data: data,
    );
  }
}
