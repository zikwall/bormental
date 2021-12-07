// native
import 'package:flutter/material.dart';

// dependencies
import 'package:animated_text_kit/animated_text_kit.dart';

Widget buildText(BuildContext context) {
  return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 35,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 7.0,
                color: Colors.white,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText('BORMENTAL'),
              FlickerAnimatedText('TV'),
            ],
            onTap: () {
              print("Tap Event");
            },
          ),
        ),
      )
  );
}

Widget buildTextAfter(BuildContext context) {
  const colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  const colorizeTextStyle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w900,
    fontFamily: 'Poppins',
  );

  return SizedBox(
    child: AnimatedTextKit(
      animatedTexts: [
        ColorizeAnimatedText(
          'Bormental',
          textStyle: colorizeTextStyle,
          colors: colorizeColors,
        ),
      ],
      isRepeatingAnimation: true,
      onTap: () {
        print("Tap Event");
      },
    ),
  );
}