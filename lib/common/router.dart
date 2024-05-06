import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smartproduction_planorama/common/constants.dart';
import 'package:smartproduction_planorama/view/home.view.dart';
import 'package:smartproduction_planorama/view/widget/sidenavigation.widget.dart';

import '../providers/login.controller.provider.dart';
import '../providers/states/login.states.dart';
import '../view/login.view.dart';
import 'logging.dart';

final log = Logging('router.dart');

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
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen<LoginState>(
      loginControllerProvider,
        (_, __) => notifyListeners(),
    );
  }

  String? _redirectLogic (BuildContext context, GoRouterState state) {

    //Login Redirect Logic
    final loginState = _ref.read(loginControllerProvider);

    final loggingIn = state.matchedLocation == RoutesPaths.login;

    if (loginState is LoginStateInitial) {
      log.logDebug('LoginState: $loginState');
      return loggingIn ? null : RoutesPaths.login;
    }

    if (loginState is LoginStateError) {
      log.logDebug('LoginState: $loginState');
      return loggingIn ? null : RoutesPaths.login;
    }

    if (loggingIn) {
     log.logDebug('LoggingIn: $loggingIn');
      return RoutesPaths.home;
    }



      return null;
    }

  List<GoRoute> get _routes => [
    GoRoute(
      path: RoutesPaths.root,
      builder: (context, state) => const SideNavigationWidget(),
    ),
    GoRoute(
      path: RoutesPaths.login,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: RoutesPaths.home,
      builder: (context, state) => const HomeView()
    )
  ];
}