import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:smartproduction_planorama/common/appwriteClient.dart';
import 'package:smartproduction_planorama/common/logging.dart';

import '../common/constants.dart';

class AuthService {
  late Account _account;
  late Client client;
  final logging = Logging();

  AuthService() {
    client = Client()
        .setEndpoint('${AppwriteConstant.endpoint}/v1')
        .setProject(AppwriteConstant.projectID)
        .setSelfSigned(status: true);
    _account = Account(client);
  }
  
  
  
  Future<void> login() async {
    try {
      logging.logInfo('Start Login Process');
      await FlutterWebAuth2.authenticate(
          url: '${AppwriteConstant.endpoint}/v1/account/sessions/oauth2/microsoft?project=${AppwriteConstant.projectID}',
          callbackUrlScheme: 'appwrite-callback-${AppwriteConstant.projectID}');
      await _account.createOAuth2Session(
        provider: OAuthProvider.microsoft,

      );
    } on AppwriteException catch (e, stackTrace) {
      logging.logError('Login failed', e, stackTrace);
    } catch (i, stacktrace) {
      logging.logError('System Error', i, stacktrace);
    }
  }
}