import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartproduction_planorama/providers/states/login.states.dart';
import 'package:smartproduction_planorama/repository/auth.repository.dart';

import '../common/logging.dart';
import '../service/auth.service.dart';
import 'client.provider.dart';

final log = Logging('login.provider.dart');

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier(ref);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.read(authServiceProvider));
});

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.read(clientProvider));
});

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier(this._ref) : super(const LoginStateInitial()) {
    checkSession();
  }

  final Ref _ref;

  void login(String email, String password) async {
    state = const LoginStateLoading();
    log.logInfo('State = $state');
    try{
      await _ref.read(authRepositoryProvider).login(email, password);
      state = const LoginStateSuccess();
      log.logInfo('State = $state');
    } catch (e) {
      state = LoginStateError(e.toString());
    }
  }

  void logout() async {
    await _ref.read(authRepositoryProvider).logout();
    state = const LoginStateInitial();
  }

  void checkSession() async {
    final isLoggedIn = await _ref.read(authRepositoryProvider).checkSession();
    state = isLoggedIn ? const LoginStateSuccess() : const LoginStateInitial();
    log.logInfo('State = $state');
  }
}
