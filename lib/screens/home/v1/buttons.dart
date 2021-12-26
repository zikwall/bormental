// native
import 'package:flutter/material.dart';

Widget buttonIcon(IconData icon, Color color, Function onTap) {
  return InkWell(
    onTap: () => onTap(),
    child: Icon(icon, color: color, size: 20),
  );
}