import 'package:appwrite/appwrite.dart';
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
    logging.logInfo('AuthService initialized');
  }

  Future<void> login(String email, String password) async {
    try {
      logging.logInfo('Start Login Process');
      await _account.createEmailPasswordSession(
          email: email, password: password);
    } on AppwriteException catch (e, stackTrace) {
      logging.logError('Login failed', e, stackTrace);
    } catch (i, stacktrace) {
      logging.logError('System Error', i, stacktrace);
    }
  }

  Future<void> logout() async {
    try {
      await _account.deleteSession(sessionId: 'current');
    } on AppwriteException catch (e, stackTrace) {
      logging.logError('Logout failed', e, stackTrace);
    } catch (i, stacktrace) {
      logging.logError('System Error', i, stacktrace);
    }
  }
}