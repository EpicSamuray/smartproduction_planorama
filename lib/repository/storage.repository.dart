import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/logging.dart';
import '../providers/storage.provider.dart';
import '../service/storage.service.dart';

final Logging log = Logging('storage.repository.dart');



class StorageRepository {
  final StorageService _dataSource;

  StorageRepository(this._dataSource);

  Future<String> downloadFile(String bucketId, String fileId) async {
    bool isDownloaded = false;
    String path = '';
    Map<String, dynamic> result  = await _dataSource.downloadImages(bucketId, fileId);

    isDownloaded = result['isDownloaded'];
    path = result['path'];

    if (isDownloaded) {
      log.logInfo('File downloaded to $path');
      return path;
    } else {
      log.logError('Error downloading file');
      return '';
    }
  }
}