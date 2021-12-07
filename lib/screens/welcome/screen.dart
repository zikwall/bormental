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

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  late VideoPlayerController _controller;
  late VoidCallback _listener;
  late AnimationController _animation;
  late Animation<double> _fadeInFadeOut;

  bool _isEnd = false;
  bool _isOnBoarded = false;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(vsync: this, duration: const Duration(milliseconds: 500),);
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 0.1).animate(_animation);
    _controller = VideoPlayerController.asset('assets/videos/bg_video7.mp4');

    _listener = () {
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

    _controller.addListener(_listener);
    _controller.setLooping(false);
    //_controller.setVolume(0.0);
    _controller.initialize().then((_) => setState(() {}));

    Timer(const Duration(seconds: 5),() {
      setState(() {
        _isOnBoarded = true;
      });

      _controller.play();
      _animation.forward();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_listener);
    _controller.dispose();

    print("CLEAR RESOURCES");
  }

  @override
  Widget build(BuildContext context) {
    if (!_isOnBoarded) {
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

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
            backgroundColor: Colors.black,
            body: FadeTransition(
              opacity: _animation,
              child: Stack(
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
            )
        )
    );
  }
}