import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartproduction_planorama/service/authService.dart';

final authServiceProvider = Provider((ref) => AuthService());

final loginProvider = FutureProvider<void>((ref) async {
  final authService = ref.read(authServiceProvider);
  await authService.login();
});