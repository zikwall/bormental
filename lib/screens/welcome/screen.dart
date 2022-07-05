// native
import 'dart:async';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// dependencies
import 'package:video_player/video_player.dart';

// application
import 'animated.dart';
import 'package:bormental/helpers/platform.dart';
import 'package:bormental/transitions/fade.dart';
import 'package:bormental/screens/home/v2/screen.dart';
import 'package:bormental/screens/welcome/popups.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({ Key? key }) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  late VideoPlayerController _controller;
  late VoidCallback _listener;
  late AnimationController _animation;

  final List<String> advanced = [
    "com.example.check",
  ];

  bool _isEnd = false;
  bool _isOnBoarded = false;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _controller = VideoPlayerController.asset('assets/videos/1_5.mp4');

    _listener = () {
      if (_controller.value.isInitialized) {
        Duration duration = _controller.value.duration;
        Duration position = _controller.value.position;
        if (!_isEnd && position.inMilliseconds >= duration.inMilliseconds) {
          setState(() {
            _isEnd = true;
          });
          Timer(const Duration(milliseconds: 3200),() {
            setState(() {
              _isOnBoarded = true;
            });
            // for access context use schedule instance, or use Future
            // ```dart
            //  Future.delayed(Duration.zero,() {
            //    popup.show(context, ...);
            //  }
            // ```
            SchedulerBinding.instance!.addPostFrameCallback((_) {
              // call API
              // return checked apps
              // return banner message
              // return another
              PlatformHelper.isInstalledOneOfPackages(advanced).then((value) {
                if (value == false) {
                  // check banner message exist
                  // create custom banner^
                  //  - message
                  //  - update
                  //  - warning and etc.
                  // example update message banner
                  showUpdatePopup(context).then((value) => {
                    if (!value) {
                      Navigator.pushReplacement(context, FadeRoute(
                        page: const HomeScreen(),
                      ))
                    } else {
                      Navigator.pushReplacement(context, FadeRoute(
                        page: const HomeScreen(),
                      ))
                    }
                  });
                } else {
                  showBanPopup(context);
                }
              });
            });
          });
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
      return const AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: Colors.black,
            body: OnBoardIntro(),
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
                  const Positioned.fill(
                    bottom: 30,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: OverlayBox(),
                    ),
                  ),
                ],
              ),
            )
        )
    );
  }
}