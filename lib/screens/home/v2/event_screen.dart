import 'dart:async';
import 'package:flutter/material.dart';

// ignore: constant_identifier_names
const SCALE_ANIMATION_STANDARD = 100;
// ignore: constant_identifier_names
const POP_STANDARD = 130;

const Map<String, Map<String, String>> provider = {
  "1": {
    "title": "Матрица: Воскрешение",
    "text": "Смотрите фантастический боевик Матрица: Воскрешение на Bormental TV с неподражаемым Киану Ривзом",
  },
  "2": {
    "title": "Человек-Паук: Через вселенные",
    "text": "Пауки из разных измерений объединяются перед общей угрозой. Изобретательный кинокомикс с «Оскаром» за анимацию",
  },
  "3": {
    "title": "Попробуйте наше новое приложение",
    "text": "Bormental Plus++",
  },
};

class EventScreen extends StatefulWidget {
  final String id;
  final String image;

  const EventScreen({Key? key,
    required this.id,
    required this.image,
  }) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> with TickerProviderStateMixin {
  /// [_heightController] controls transition when router pushs
  late AnimationController _heightController;
  late Animation<double> _heightAnimation;

  /// NOTE: pop transition is differnt to push transition.
  late Animation<double> _heightBackAnimation;

  /// [_closeController] controls transition when router pops.
  late AnimationController _closeController;
  late Animation _closeAnimation;

  /// When user scrolls to the top but not triggers pop's transition.
  /// Then Text Section has bouncing animation.
  late AnimationController _textOffsetController;
  late Animation _textOffsetAnimation;

  /// When user point down.
  late double _initPoint;
  // Calculate vertical distance.
  late double _verticalDistance;

  late bool _needPop;
  late bool _isTop;
  late bool _opactity;
  late String text;
  late String title;

  @override
  void initState() {
    _needPop = true;
    _isTop = true;
    _opactity = false;

    _heightController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _closeController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 400));

    _closeAnimation =
        Tween<double>(begin: 1.0, end: 0.75).animate(_closeController);

    _heightAnimation = Tween<double>(begin: .9, end: 1).animate(
        CurvedAnimation(curve: Curves.easeIn, parent: _heightController));

    _heightBackAnimation = Tween<double>(begin: 0.6, end: 1).animate(
        CurvedAnimation(curve: Curves.easeIn, parent: _heightController));

    super.initState();

    // Trigger push animation.
    _heightController.forward();

    Timer(const Duration(milliseconds: 250), () {
      setState(() {
        _opactity = true;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      title = provider[widget.id]!["title"]!;
      text = provider[widget.id]!["text"]!;
    });
  }

  @override
  void dispose() {
    _closeController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.85),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: AnimatedBuilder(
          animation: _closeAnimation,
          builder: (context, _child) {
            // only trigger at router pop.
            return Transform.scale(
              scale: _closeAnimation.value,
              child: _child,
            );
          },
          child: AnimatedOpacity(
            opacity: _opactity ? 1 : 0,
            duration: const Duration(milliseconds: 150),
            // Controls Container height.
            child: SizeTransition(
              sizeFactor: _needPop ? _heightAnimation : _heightBackAnimation,
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(
                  minHeight: 300,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 10,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Listener(
                  onPointerDown: (opm) {
                    _initPoint = opm.position.dy;
                  },
                  onPointerUp: (opm) {
                    if (_needPop) {
                      _closeController.reverse();
                    }
                  },
                  onPointerMove: (opm) {
                    _verticalDistance = -_initPoint + opm.position.dy;
                    if (_verticalDistance >= 0) {
                      // scroll up
                      if (_isTop == true &&
                          _verticalDistance < SCALE_ANIMATION_STANDARD) {
                        double _scaleValue = double.parse(
                            (_verticalDistance / 100).toStringAsFixed(2));
                        _closeController.animateTo(_scaleValue,
                            duration: const Duration(milliseconds: 0),
                            curve: Curves.linear);
                      } else if (_isTop == true &&
                          _verticalDistance >= SCALE_ANIMATION_STANDARD &&
                          _verticalDistance < POP_STANDARD) {
                        // stop animation
                        _closeController.animateTo(1,
                            duration: const Duration(milliseconds: 0),
                            curve: Curves.linear);
                      } else if (_isTop == true &&
                          _verticalDistance >= POP_STANDARD) {
                        if (_needPop) {
                          // pop
                          _needPop = false;
                          _closeController.fling(velocity: 1).then((_) {
                            _heightController.reverse();
                            Navigator.of(context).pop();
                            _opactity = false;
                          });
                        }
                      }
                    } else {
                      _isTop = false;
                    }
                  },
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      // scroll update function
                      if (scrollNotification is ScrollUpdateNotification) {
                        double scrollDistance = scrollNotification.metrics.pixels;
                        if (scrollDistance <= 3) {
                          _isTop = true;
                        }
                      }
                      return true;
                    },
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverAppBar(
                          expandedHeight: 300,
                          // hide the back button
                          leading: Container(),
                          backgroundColor: Colors.white,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Hero(
                              tag: widget.id,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: Image.network(
                                  widget.image,
                                  fit: BoxFit.cover,
                                  height: 300,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 50, bottom: 30
                                ),
                                width: double.infinity,
                                child: Column(
                                  children: <Widget>[
                                    Text(title, style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black)),
                                    const SizedBox(height: 30),
                                    Text(text, style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}