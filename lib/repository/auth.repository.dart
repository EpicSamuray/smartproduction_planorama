import 'package:appwrite/models.dart';

import '../service/auth.service.dart';

class AuthRepository {
  final AuthService _authService;
  AuthRepository(this._authService);

  Future<Session> login(String email, String password) async {
    return _authService.login(email, password);
  }

  Future<void> logout() async {
    return _authService.logout();
  }

  Future<bool> checkSession() async {
    return _authService.isLoggedIn();
  }
}
