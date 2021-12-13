// native
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// dependencies
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// application
import 'cards.dart';
import 'whatsup.dart';

// fonts
import 'package:bormental/fonts/fontisto_icons.dart';

final categories = <CardContent>[
  CardContent(
    'Популярные',
    20,
    'Самые просматриваемые каналы по версии пользователей',
    (Random()).nextInt(100),
  ),
  CardContent(
    'Региональные',
    11,
    'Смотрите передачи родного села с бабушкой и дедушкой',
    (Random()).nextInt(100),
  ),
  CardContent(
    'Развлекательные',
    45,
    'То, что надо для отдыха после тяжелого рабочего дня, скучно не будет',
    (Random()).nextInt(100),
  ),
  CardContent(
    'Спортивные',
    7,
    'Быстрее. Выше. Сильнее. Добро пожаловать в мир спорта',
    (Random()).nextInt(100),
  ),
  CardContent(
    'Детские',
    105,
    'Надоели спиногрызы? Включите им канал из данной категории - мы позаботимся о них',
    (Random()).nextInt(100),
  ),
  CardContent(
    'Музыкальные',
    25,
    'Моргенчлен, Баста и еще мало знкомые люди ждут Вас',
    (Random()).nextInt(100),
  ),
  CardContent(
    'Новостные',
    12,
    'Будьте вкурсе, кого на этот раз посадили',
    (Random()).nextInt(100),
  ),
  CardContent(
    'Позновательные',
    9,
    'Зашли сюда деградировать? Тогда мотайте дальше',
    (Random()).nextInt(100),
  ),
  CardContent(
    'Фильмы',
    37,
    'Фильмы, сериалы, аниме, хентай, шутка, сериалов тут нет',
    (Random()).nextInt(100),
  ),
  CardContent(
    'Избранные',
    777,
    'Все твои любимые категории в одной, как прекрасно',
    (Random()).nextInt(100),
  ),
];

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
    _animation = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 500),
    );
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);

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
                top: MediaQuery.of(context).size.height * 0.10
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
                  colors: getColorList(Colors.blue),
                )
            ),
            child: OrientationBuilder(
              builder: (context, orientation) {
                return FadeTransition(
                  opacity: _animation,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.13,
                              right: MediaQuery.of(context).size.width * 0.05,
                              bottom: MediaQuery.of(context).size.height * 0.05,
                          ),
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget>[
                              Icon(Fontisto.search, color: Colors.white),
                              Icon(Fontisto.nav_icon_list_a, color: Colors.white),
                            ],
                          ),
                        ),
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