import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartproduction_planorama/common/logging.dart';
import '../providers/client.provider.dart';

final log = Logging('auth.service.dart');


final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.read(clientProvider));
});

class AuthService {
  final Client _client;

  AuthService(this._client);

  Account get account => Account(_client);

  Future<bool> isLoggedIn() async {
    try {
      await getUser();
      return true;
    } catch (e){
      return false;
    }
  }

  Future<User> getUser() async {
    try {
      log.logInfo('Start Get User Process');
      return await account.get();
    } on AppwriteException catch (e, stackTrace) {
      log.logError('Get User failed', e, stackTrace);
      rethrow;
    } catch (i, stacktrace) {
      log.logError('System Error', i, stacktrace);
      rethrow;
    } finally {
      log.logInfo('User: $User');
    }
  }

  Future<Session> login(String email, String password) async {
    try {
      log.logInfo('Start Login Process');
      return await account.createEmailPasswordSession(
          email: email, password: password);
    } on AppwriteException catch (e, stackTrace) {
      log.logError('Login failed', e, stackTrace);
      rethrow;
    } catch (i, stacktrace) {
      log.logError('System Error', i, stacktrace);
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await account.deleteSession(sessionId: 'current');
    } on AppwriteException catch (e, stackTrace) {
      log.logError('Logout failed', e, stackTrace);
    } catch (i, stacktrace) {
      log.logError('System Error', i, stacktrace);
    }
  }
}