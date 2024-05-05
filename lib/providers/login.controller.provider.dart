import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartproduction_planorama/providers/states/login.states.dart';
import 'package:smartproduction_planorama/repository/auth.repository.dart';

import '../common/logging.dart';

class LoginController extends StateNotifier<LoginState> {
  LoginController(this._ref) : super(const LoginStateInitial()) {
    checkSession();
  }
  final Logging log = Logging();

  final Ref _ref;

  void login(String email, String password) async {
    state = const LoginStateLoading();
    try{
      await _ref.read(authRepositoryProvider).login(email, password);
      state = const LoginStateSuccess();
      log.logInfo('LoginController: loginState.login = $state');
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
    log.logInfo('LoginController: loginState.checkSession = $state');
  }
}

final loginControllerProvider = StateNotifierProvider<LoginController, LoginState>((ref) {
  return LoginController(ref);
});