import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/appwrite.dart';

import '../common/constants.dart';
import '../common/logging.dart';

final log = Logging('client.provider.dart');

final clientProvider = Provider<Client>((ref) {
  log.logInfo('Client Provider started');
  return Client()
      .setEndpoint('${AppwriteConstant.endpoint}/v1')
      .setProject(AppwriteConstant.projectID)
      .setSelfSigned(status: true);
});
