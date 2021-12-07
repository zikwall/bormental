// native
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// dependencies
//

// application
import 'cards.dart';
import 'whatsup.dart';

List<Color> getColorList(Color color) {
  if (color is MaterialColor) {
    return [
      color.shade300,
      color.shade600,
      color.shade700,
      color.shade900,
    ];
  } else {
    return List<Color>.filled(4, color);
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animation;
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000),);
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);

    _animation.forward();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final _tasks = [1, 2, 3, 4, 5];

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
                top: MediaQuery.of(context).size.height * 0.15
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
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.3, 0.5, 0.7, 0.9],
                  colors: getColorList(Colors.purple),
                )
            ),
            child: OrientationBuilder(
              builder: (context, orientation) {
                return FadeTransition(
                  opacity: _animation,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        orientation == Orientation.landscape
                            ? buildWhatsUpHorizontal(context)
                            : buildWhatsUp(context),
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
                              controller: _pageController,
                              itemBuilder: (BuildContext context, int index) {
                                if (index == _tasks.length) {
                                  return buildCardNew(context);
                                } else {
                                  return buildCardCategory(context);
                                }
                              },
                              itemCount: _tasks.length + 1,
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