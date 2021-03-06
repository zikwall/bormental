import 'package:flutter/material.dart';

class TitledNavigationBarItem {
  final Widget title;
  final IconData icon;
  final Color backgroundColor;
  final double size;

  TitledNavigationBarItem({
    required this.icon,
    required this.title,
    this.backgroundColor = Colors.white,
    required this.size,
  });
}
