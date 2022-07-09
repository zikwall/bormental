// native
import 'package:flutter/material.dart';

// dependencies
import 'package:animated_text_kit/animated_text_kit.dart';

class OnBoardIntro extends StatelessWidget {
  const OnBoardIntro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                debugPrint("Tap Event");
              },
            ),
          ),
        )
    );
  }
}

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

class TextAfterRender extends StatelessWidget {
  const TextAfterRender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          debugPrint("Tap Event");
        },
      ),
    );
  }
}

class RandomAdvices extends StatelessWidget {
  const RandomAdvices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            debugPrint("Tap Event");
          },
        ),
      ),
    );
  }
}

class OverlayBox extends StatelessWidget {
  const OverlayBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.landscape) {
        return Container();
      }
      return SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const CircularProgressIndicator(
              color: Colors.blue, strokeWidth: 1,
            ),
            Column(
              children: const [
                RandomAdvices(),
                SizedBox(height: 7),
                TextAfterRender(),
              ],
            ),
          ],
        ),
        height: 200,
        width: MediaQuery.of(context).size.width - 50,
      );
    });
  }
}