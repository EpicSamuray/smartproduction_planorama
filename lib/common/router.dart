import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/login.controller.provider.dart';
import '../providers/states/login.states.dart';
import '../view/Login.dart';
import '../view/home.dart';
import 'logging.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);
  return GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: router,
    redirect: router._redirectLogic,
    routes: router._routes,
  );
});

class RouterNotifier extends ChangeNotifier {
  final Logging log = Logging();
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen<LoginState>(
      loginControllerProvider,
        (_, __) => notifyListeners(),
    );
  }

  String? _redirectLogic (BuildContext context, GoRouterState state) {
    final loginState = _ref.read(loginControllerProvider);

    final loggingIn = state.matchedLocation == '/login';

    log.logInfo('RouterNotifier: loginState._redirectLogic is $loginState');
    log.logInfo('RouterNotifier: loggingIn._redirectLogic is $loggingIn');

    if (loginState is LoginStateInitial) {
      log.logInfo('RouterNotifier: loginState._redirectLogic is $loginState');
      return loggingIn ? null : '/login';
    }

    if (loginState is LoginStateError) {
      log.logInfo('RouterNotifier: loginState._redirectLogic is $loginState');
      return loggingIn ? null : '/error';
    }

    if (loggingIn) {
     log.logInfo('RouterNotifier: loggingIn._redirectLogic is $loggingIn');
      return '/';
    }
      return null;
    }

  List<GoRoute> get _routes => [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
  ];
}