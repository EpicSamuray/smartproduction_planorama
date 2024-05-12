import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smartproduction_planorama/common/constants.dart';
import 'package:smartproduction_planorama/view/widget/menu.button.widget.dart';
import 'package:smartproduction_planorama/view/widget/menu.list.widget.dart';

import '../../common/logging.dart';
import '../../providers/login.provider.dart';

final log = Logging('sidenavigation.widget.dart');

class SideNavigationWidget extends ConsumerStatefulWidget {
  final Widget child;

  const SideNavigationWidget({super.key, required this.child});

  @override
  ConsumerState<SideNavigationWidget> createState() =>
      _SideNavigationWidgetState();
}

class _SideNavigationWidgetState extends ConsumerState<SideNavigationWidget> {
  int currentIndex = 0;

  List<Icon> menuIcons = [
    const Icon(Icons.dashboard),
    const Icon(Icons.account_tree_outlined),
    const Icon(Icons.person, color: Colors.white),
    const Icon(Icons.logout, color: Colors.white),
  ];

  List<Widget> menuItems = [
    const Text('Dashboard',
        style: TextStyle(color: Colors.white, fontSize: 20)),
    const Text('Machine Planning',
        style: TextStyle(color: Colors.white, fontSize: 20)),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            const EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 30),
        child: Row(
          children: [
            SizedBox(
              width: 300,
              height: double.infinity,
              child: ClayContainer(
                color: HexColors.primaryColor.shade900,
                borderRadius: 25,
                depth: 20,
                spread: 5,
                child: Column(
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      height: 180,
                      child: DrawerHeader(
                          child: Column(
                        children: [
                          Image(
                            image: AssetImage(ImagePaths.logo),
                            fit: BoxFit.fill,
                            width: 100,
                          ),
                          SizedBox(width: 10),
                          Text('Planorama',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 40)),
                          SizedBox(height: 10),
                          Text('Felice Pettinaro',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        ],
                      )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    MenuListWidget(
                        borderRadius: 15,
                        width: 260,
                        spaceBetweenItems: 20,
                        menuItems: menuItems,
                        onMenuSelected: (index) {
                          log.logInfo('Menu selected: $index');
                          switch (index) {
                            case 0:
                              context.go(RoutesPaths.root);
                              break;
                            case 1:
                              context.go(RoutesPaths.machine_planning);
                              break;
                            default:
                              break;
                          }
                        },
                        menuIcons: menuIcons),
                    Expanded(
                      child: Container(),
                    ),
                    SizedBox(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MenuButtonWidget(
                                isOutside: true,
                                onlyIcon: true,
                                width: 50,
                                height: 50,
                                onPressed: () {
                                  ref
                                      .read(loginProvider.notifier)
                                      .logout();
                                },
                                icon: const Icon(Icons.logout,
                                    color: Colors.white),
                                borderRadius: 15),
                            MenuButtonWidget(
                                isOutside: true,
                                onlyIcon: true,
                                width: 50,
                                height: 50,
                                onPressed: () {},
                                icon: const Icon(Icons.settings,
                                    color: Colors.white),
                                borderRadius: 15)
                          ],
                        )),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: widget.child,
              ),
            ),
          ],
        ));
  }
}

void changePage(int index) {
  log.logInfo('Page changed: $index');
  switch (index) {}
}
