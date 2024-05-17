import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/logging.dart';
import '../repository/storage.repository.dart';
import '../service/storage.service.dart';
import 'client.provider.dart';
import 'machine.provider.dart';

final log = Logging('storage.provider.dart');

final storageProvider = Provider<Storage>((ref) {
  log.logInfo('Client Provider started');
  return Storage(ref.read(clientProvider));
});

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService(ref.watch(storageProvider));
});

final storageRepositoryProvider =
    Provider.autoDispose<StorageRepository>((ref) {
  return StorageRepository(
      ref.watch(storageServiceProvider), ref.watch(machineProvider.notifier));
});
