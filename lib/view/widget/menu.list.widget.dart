import 'package:flutter/material.dart';
import 'package:smartproduction_planorama/common/constants.dart';
import 'package:smartproduction_planorama/shared/widget/neumorphism/neumorphism_button_widget.dart';

class MenuListWidget extends StatefulWidget {
  final List<Widget> menuItems;
  final List<Icon> menuIcons;
  final double? borderRadius;
  final Color color;
  final double? spaceBetweenItems;
  final double? width;
  final double? buttonHeigth;
  final Function(int) onMenuSelected;

  const MenuListWidget(
      {super.key,
      required this.menuItems,
      required this.onMenuSelected,
      required this.menuIcons,
      this.borderRadius = 0,
      required this.color,
      this.spaceBetweenItems = 0,
      this.width = 200,
      this.buttonHeigth});

  @override
  State<MenuListWidget> createState() => _MenuListWidgetState();
}

class _MenuListWidgetState extends State<MenuListWidget> {
  int _selectedIndex = -1;

  void _onPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onMenuSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.menuItems.length, (index) {
          return Column(
            children: [
              SizedBox(
                height: widget.spaceBetweenItems,
              ),
              NeumorphismButtonWidget(
                blur: NeumorphismConstants.blur,
                distance: NeumorphismConstants.distance,
                title: widget.menuItems[index],
                onPressed: () => _onPressed(index),
                icon: widget.menuIcons[index],
                isActivated: _selectedIndex == index,
                borderRadius: widget.borderRadius,
                width: widget.width,
                height: widget.buttonHeigth,
                color: widget.color,
              ),
            ],
          );
        }),
      ),
    );
  }
}
