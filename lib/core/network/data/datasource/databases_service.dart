import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartproduction_planorama/common/toJson.abstract.dart';
import 'package:smartproduction_planorama/providers/client.provider.dart';

final databaseServiceProvider = Provider<DatabasesSerivce>((ref) {
  return DatabasesSerivce(ref.read(clientProvider));
});

class DatabasesSerivce {
  final Client client;

  DatabasesSerivce(this.client);

  Databases get database => Databases(client);


  Future<Document> createDocument({
    required String collectionId,
    required String databaseId,
    required String documentId,
    List<String>? permissions,
    required JsonSerializable data,
}) async {
    try {
      return permissions == [] ?
       await database.createDocument(
        collectionId: collectionId,
        databaseId: databaseId,
        documentId: documentId,
        data: data.toJson(),
      )
      :
      await database.createDocument(
        collectionId: collectionId,
        databaseId: databaseId,
        documentId: documentId,
        data: data.toJson(),
        permissions: permissions,
      );
    } on AppwriteException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Document> deleteDocument({
    required String collectionId,
    required String databaseId,
    required String documentId,
}) async {
    try {
      return await database.deleteDocument(
        collectionId: collectionId,
        databaseId: databaseId,
        documentId: documentId,
      );
    } on AppwriteException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Document> getDocument({
    required String collectionId,
    required String databaseId,
    required String documentId,
    List<String>? queries
}) async {
    try {
      return await database.getDocument(
        collectionId: collectionId,
        databaseId: databaseId,
        documentId: documentId,
        queries: queries,
      );
    } on AppwriteException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<DocumentList> listDocument({
    required String collectionId,
    required String databaseId,
    List<String>? queries,
}) async {
    try {
      return await database.listDocuments(
        collectionId: collectionId,
        databaseId: databaseId,
        queries: queries,
        );
    } on AppwriteException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<Document> updateDocument({
    required String collectionId,
    required String databaseId,
    required String documentId,
    JsonSerializable? data,
    List<String>? permissions
}) async {
    try {
      return await database.updateDocument(
        collectionId: collectionId,
        databaseId: databaseId,
        documentId: documentId,
        data: data?.toJson(),
        permissions: permissions,
      );
    } on AppwriteException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}