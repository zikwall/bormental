import 'package:flutter/material.dart';
import 'package:bormental/fonts/fontisto_icons.dart';

Widget _buildOurSocials() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const <Widget>[
      Icon(
        Fontisto.github,
        color: Colors.black,
        size: 20,
      ),
      SizedBox(width: 25),
      Icon(
        Fontisto.telegram,
        color: Colors.black,
        size: 20,
      ),
      SizedBox(width: 25),
      Icon(
        Fontisto.vk,
        color: Colors.black,
        size: 20,
      ),
      SizedBox(width: 25),
      Icon(
        Fontisto.facebook,
        color: Colors.black,
        size: 20,
      ),
      SizedBox(width: 25),
      Icon(
        Fontisto.behance,
        color: Colors.black,
        size: 20,
      ),
    ],
  );
}