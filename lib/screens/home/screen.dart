// native
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// dependencies
//

// application
//

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
  late AnimationController _controller;
  late Animation<double> _animation;
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
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
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      orientation == Orientation.landscape
                        ? _buildWhatsUpHorizontal(context)
                        : _buildWhatsUp(context),
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
                              return _buildCard(context);
                            },
                            itemCount: _tasks.length + 1,
                          ),
                        ),
                      ),
                    ]
                );
              },
            ),
          ),
        )
    );
  }
}

Widget _buildWhatsUpHorizontal(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(
      left: MediaQuery.of(context).size.width * 0.115,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'What\'s up?',
          style: Theme.of(context)
              .textTheme
              .headline4
              ?.copyWith(color: Colors.white),
        ),
      ],
    ),
  );
}

Widget _buildWhatsUp(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(
      left: MediaQuery.of(context).size.width * 0.13,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'What\'s up?',
          style: Theme.of(context)
              .textTheme
              .headline4
              ?.copyWith(color: Colors.white),
        ),
        Text(
          'Good evening',
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(
              color: Colors.white.withOpacity(0.7)),
        ),
        Container(height: 16.0),
        Text(
          'You have 5 tasks to complete',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(
              color: Colors.white.withOpacity(0.7)),
        ),
        Container(
          height: 16.0,
        )
      ],
    ),
  );
}

Widget _buildCard(BuildContext context) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    elevation: 4.0,
    margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
    child: Material(
      borderRadius: BorderRadius.circular(16.0),
      color: Colors.white,
      child: InkWell(
        onTap: () {
          //
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add,
                size: 52.0,
                color: Colors.black,
              ),
              Container(
                height: 8.0,
              ),
              const Text(
                'Add Category',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}