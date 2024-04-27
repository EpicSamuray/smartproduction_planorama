import 'package:appwrite/appwrite.dart';
import 'package:smartproduction_planorama/common/constants.dart';
import 'package:smartproduction_planorama/common/logging.dart';

class AppwriteClient {
  static final AppwriteClient _instance = AppwriteClient._internal();
  final logging = Logging();

  late final Client client;
  
  factory AppwriteClient() => _instance;

  AppwriteClient._internal() {
    logging.logInfo('AppwriteClient started');
     client = Client()
         .setEndpoint(AppwriteConstant.endpoint)
         .setProject(AppwriteConstant.projectID)
         .setSelfSigned(status: true);
  }

}