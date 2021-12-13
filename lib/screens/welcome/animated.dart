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
              FlickerAnimatedText('ZIKWALL'),
              FlickerAnimatedText('PRODUCTION'),
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
    Colors.blue,
    Color(0xff34a0a4),
    Color(0xff52b69a),
    Color(0xff99d98c),
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

Widget buildRandomText(BuildContext context) {
  return SizedBox(
    child: DefaultTextStyle(
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 14.0,
        color: Colors.black,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
      ),
      child: AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText('loading assets...'),
          TypewriterAnimatedText('compiling resources...'),
          TypewriterAnimatedText('hate JavaScript language...'),
          TypewriterAnimatedText('it seems almost everything...'),
          TypewriterAnimatedText('we pretend to be busy...'),
          TypewriterAnimatedText('it\'s almost, just a little bit'),
        ],
        onTap: () {
          print("Tap Event");
        },
      ),
    ),
  );
}

Widget buildOverlayBox(BuildContext context) {
  return OrientationBuilder(builder: (context, orientation) {
    if (orientation == Orientation.landscape) {
      return Container();
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CircularProgressIndicator(
            color: Colors.blue, strokeWidth: 1,
          ),
          Column(
            children: [
              buildRandomText(context),
              const SizedBox(height: 7),
              buildTextAfter(context),
            ],
          ),
        ],
      ),
      height: 200,
      width: MediaQuery.of(context).size.width - 50,
    );
  });
}