import 'package:flutter/cupertino.dart';

class BottomNavItem {

  final String label;
  final Icon icon;
  final Widget screen;

  BottomNavItem({
    required this.label,
    required this.icon,
    required this.screen
  });
}