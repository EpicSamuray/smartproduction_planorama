import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smartproduction_planorama/common/constants.dart';
import 'package:smartproduction_planorama/view/home.view.dart';
import 'package:smartproduction_planorama/view/machine_planning.view.dart';
import 'package:smartproduction_planorama/view/widget/sidenavigation.widget.dart';

import '../providers/login.provider.dart';
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
      loginProvider,
        (_, __) => notifyListeners(),
    );
  }

  String? _redirectLogic (BuildContext context, GoRouterState state) {

    //Login Redirect Logic
    final loginState = _ref.read(loginProvider);
    final loggingIn = state.matchedLocation == RoutesPaths.login;
    return checkLoginStates(loggingIn, loginState);


    }

  List<RouteBase> get _routes => [
    ShellRoute(
      builder: (context, state, child) {
        return SideNavigationWidget(child: child);
      },
        routes: [
          GoRoute(
            path: RoutesPaths.root,
            builder: (context, state) => const HomeView()
          ),
          GoRoute(
            path: RoutesPaths.machine_planning,
            builder: (context, state) => const MachinePlanningView()
          )
        ]
    ),
    GoRoute(
      path: RoutesPaths.login,
      builder: (context, state) => const LoginView(),
    ),
  ];
}

String? checkLoginStates(bool loggingIn, LoginState loginState) {
  switch (loginState.runtimeType) {
    case LoginStateInitial:
      log.logDebug('Initial - LoginState: $loginState');
      return loggingIn ? null : RoutesPaths.login;
    case LoginStateError:
      log.logDebug('Error - LoginState: $loginState');
      return loggingIn ? null : RoutesPaths.login;
    case LoginStateLoading:
      log.logDebug('Loading - LoginState: $loginState');
      return null;
    default:
      log.logDebug('default - LoginState: $loginState');
      return loggingIn ? RoutesPaths.root : null;
  }
}