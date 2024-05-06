import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartproduction_planorama/providers/states/login.states.dart';
import 'package:smartproduction_planorama/repository/auth.repository.dart';

import '../common/logging.dart';

final log = Logging('login.controller.provider.dart');

final loginControllerProvider = StateNotifierProvider<LoginController, LoginState>((ref) {
  return LoginController(ref);
});

class LoginController extends StateNotifier<LoginState> {
  LoginController(this._ref) : super(const LoginStateInitial()) {
    checkSession();
  }

  final Ref _ref;

  void login(String email, String password) async {
    state = const LoginStateLoading();
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
