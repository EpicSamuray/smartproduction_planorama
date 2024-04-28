import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartproduction_planorama/service/authService.dart';

final loginProvider = Provider<AuthService>((ref) {
  return AuthService();
});

enum AuthenticationStatus {
  initial,
  loading,
  success,
  error,
}