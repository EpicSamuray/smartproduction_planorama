import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartproduction_planorama/common/constants.dart';
import 'package:smartproduction_planorama/view/widget/menu.button.widget.dart';
import 'package:smartproduction_planorama/view/widget/menu.list.widget.dart';

import '../../common/logging.dart';
import '../../providers/login.controller.provider.dart';

final log = Logging('sidenavigation.widget.dart');

class SideNavigationWidget extends ConsumerStatefulWidget {
  final Widget child;
  const SideNavigationWidget({super.key, required this.child});

  @override
  ConsumerState<SideNavigationWidget> createState() => _SideNavigationWidgetState();
}

class _SideNavigationWidgetState extends ConsumerState<SideNavigationWidget> {
  List<Icon> menuIcons = [
    const Icon(Icons.home, color: Colors.white),
    const Icon(Icons.settings, color: Colors.white),
    const Icon(Icons.person, color: Colors.white),
    const Icon(Icons.logout, color: Colors.white),
  ];

  List<Widget> menuItems = [
    const Text('Dashboard', style: TextStyle(color: Colors.white, fontSize: 20)),
    const Text('Machine Planning', style: TextStyle(color: Colors.white, fontSize: 20)),
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(30),
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
                        },
                        menuIcons: menuIcons
                    ),
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
                                ref.read(loginControllerProvider.notifier).logout();
                              },
                              icon: const Icon(
                                  Icons.logout,
                                  color: Colors.white),
                              borderRadius: 15
                          ),
                          MenuButtonWidget(
                              isOutside: true,
                              onlyIcon: true,
                              width: 50,
                              height: 50,
                              onPressed: () {},
                              icon: const Icon(
                                  Icons.settings,
                                  color: Colors.white
                              ),
                              borderRadius: 15
                          )
                        ],
                      )
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: widget.child
            ),
          ],
        ));
  }
}
