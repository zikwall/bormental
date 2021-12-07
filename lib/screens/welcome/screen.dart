// native
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// dependencies
import 'package:video_player/video_player.dart';

// application
import 'animated.dart';
import 'package:bormental/transitions/fade.dart';
import 'package:bormental/screens/home/screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({ Key? key }) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5),() {
      Navigator.push(context, FadeRoute(page: const OnBoardScreen()));
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
          body: buildText(context),
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

  bool _isEnd = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/bg_video7.mp4');

    listener = () {
      if (_controller.value.isInitialized) {
        Duration duration = _controller.value.duration;
        Duration position = _controller.value.position;
        if (!_isEnd && position.inMilliseconds >= duration.inMilliseconds) {
          setState(() {
            _isEnd = true;
          });

          Navigator.pushReplacement(context, FadeRoute(
              page: const HomeScreen(),
          ));
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

    print("disposed resources");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                        buildTextAfter(context),
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