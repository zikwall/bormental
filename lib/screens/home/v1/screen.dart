// native
import 'dart:math';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// dependencies
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// application
import 'cards.dart';
import 'whatsup.dart';
import 'buttons.dart';
import 'mock.dart';

// fonts
import 'package:bormental/fonts/fontisto_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  // initializes
  late AnimationController _animation;
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  late PageController _pageController;

  // states
  int _currentPageIndex = 0;
  Gradient backgroundGradient = categories[0].cardGradient;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 500),
    );

    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
    _pageController.addListener(() {
      ScrollPosition position = _pageController.position;
      int page = position.pixels
          ~/ (position.maxScrollExtent
              / (categories.length.toDouble() - 1));

      double pageDo = (position.pixels
          / (position.maxScrollExtent
              / (categories.length.toDouble() - 1)));

      double percent = pageDo - page;

      if (categories.length - 1 < page + 1) {
        return;
      }

      setState(() {
        var gradient1 = categories[page].cardGradient;
        var gradient2 = categories[page + 1].cardGradient;
        // ignore: invalid_use_of_protected_member
        backgroundGradient = gradient1.lerpTo(gradient2, percent)!;
      });
    });
    _animation.forward();
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
          body: Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.073
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.shade200,
                      offset: const Offset(2, 4),
                      blurRadius: 5,
                      spreadRadius: 2
                  )
                ],
                gradient: backgroundGradient
            ),
            child: OrientationBuilder(
              builder: (context, orientation) {
                return FadeTransition(
                  opacity: _animation,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildHeaderPanel(context),
                        orientation == Orientation.landscape
                            ? buildWhatsUpHorizontal(context)
                            : buildWhatsUp(context, categories.length),
                        Expanded(
                          key: _backdropKey,
                          flex: 1,
                          child: NotificationListener<ScrollNotification>(
                            onNotification: (notification) {
                              if (notification is ScrollEndNotification) {
                                print("ScrollNotification = ${_pageController.page}");
                                var currentPage = _pageController.page?.round().toInt() ?? 0;
                                if (_currentPageIndex != currentPage) {
                                  setState(() => _currentPageIndex = currentPage);
                                }
                              }
                              return true;
                            },
                            child: PageView.builder(
                              physics: const BouncingScrollPhysics(),
                              controller: _pageController,
                              itemBuilder: (BuildContext context, int index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  child: SlideAnimation(
                                    horizontalOffset: 6.0,
                                    child: FadeInAnimation(
                                      duration: const Duration(milliseconds: 30),
                                      child: (index == categories.length)
                                          ? buildCardNew(context)
                                          : buildCardCategory(
                                          context, categories[index]
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: categories.length + 1,
                            ),
                          ),
                        ),
                      ]
                  ),
                );
              },
            ),
          ),
        )
    );
  }
}

Widget _buildHeaderPanel(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(
      left: MediaQuery.of(context).orientation == Orientation.landscape
          ? MediaQuery.of(context).size.width * 0.11
          : MediaQuery.of(context).size.width * 0.129,
      right: 20,
      bottom: MediaQuery.of(context).size.height * 0.10,
      top: MediaQuery.of(context).orientation == Orientation.landscape
          ? 29
          : 0,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        buttonIcon(Fontisto.arrow_left, Colors.white, () {}),
        buttonIcon(Fontisto.nav_icon_list_a, Colors.white, () {})
      ],
    ),
  );
}