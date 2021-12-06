// native
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// dependencies
import 'package:video_player/video_player.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

// application
//

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({ Key? key }) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

Widget _buildText(BuildContext context) {
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

Widget _buildTextAfter(BuildContext context) {
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

class FadeRoute extends PageRouteBuilder {
  final Widget page;

  FadeRoute({required this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: child,
        ),
  );
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5),() {
      Navigator.push(context, FadeRoute(page: const  OnBoardScreen()));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: Colors.black,
          body: _buildText(context),
        )
    );
  }
}

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  late VideoPlayerController _controller;
  late VoidCallback listener;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/bg_video7.mp4');

    listener = () {
      if (_controller.value.isInitialized) {
        Duration duration = _controller.value.duration;
        Duration position = _controller.value.position;
        if (duration.compareTo(position) != 1) {
          print("on END");
        }
      }
    };

    _controller.addListener(listener);
    _controller.setLooping(false);
    _controller.setVolume(0.0);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(listener);
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                height: _controller.value.size.height,
                width: _controller.value.size.width,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          Positioned.fill(
            bottom: 30,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CircularProgressIndicator(
                        color: Colors.blue, strokeWidth: 1,
                    ),
                    Column(
                      children: [
                        const Text(
                          'Hire from over lots of people through',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black
                          ),
                        ),
                        const SizedBox(height: 7),
                        _buildTextAfter(context),
                      ],
                    ),
                  ],
                ),
                height: 200,
                width: MediaQuery.of(context).size.width - 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}