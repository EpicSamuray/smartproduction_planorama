import 'package:flutter/material.dart';
import 'package:smartproduction_planorama/common/constants.dart';

class SideNavigationWidget extends StatefulWidget {
  const SideNavigationWidget({super.key});

  @override
  State<SideNavigationWidget> createState() => _SideNavigationWidgetState();
}

class _SideNavigationWidgetState extends State<SideNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          children: [
            SizedBox(
                width: 250,
                height: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomRight: Radius.circular(50)),
                      color: HexColors().primaryColor.shade900,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 15,
                            spreadRadius: 10,
                            offset: const Offset(0,0))
                      ]),
                )
                  ),
            Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 30),
            ))
          ],
        ));
  }
}
