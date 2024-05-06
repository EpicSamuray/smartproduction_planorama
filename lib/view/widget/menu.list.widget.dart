import 'package:flutter/material.dart';
import 'package:smartproduction_planorama/view/widget/menu.button.widget.dart';

class MenuListWidget extends StatefulWidget {
  final List<Widget> menuItems;
  final List<Icon> menuIcons;
  final double? borderRadius;
  final Colors? color;
  final double? spaceBetweenItems;
  final double? width;
  final Function(int) onMenuSelected;
  const MenuListWidget({
    super.key,
    required this.menuItems,
    required this.onMenuSelected,
    required this.menuIcons,
    this.borderRadius = 0,
    this.color,
    this.spaceBetweenItems = 0,
    this.width = 200
  });


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
              MenuButtonWidget(
                title: widget.menuItems[index],
                onPressed: () => _onPressed(index),
                icon: widget.menuIcons[index],
                isActivated: _selectedIndex == index,
                borderRadius: widget.borderRadius,
                width: widget.width,
              ),
            ],
          );
        }),
      ),
    );
  }
}
