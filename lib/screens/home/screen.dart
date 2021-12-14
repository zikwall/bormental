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

// fonts
import 'package:bormental/fonts/fontisto_icons.dart';

final categories = <CardContent>[
  CardContent(
    'Популярные',
    20,
    'Самые просматриваемые каналы по версии пользователей',
    (Random()).nextInt(100),
    Colors.blueAccent,
    getGradient(Colors.blueAccent),
  ),
  CardContent(
    'Региональные',
    11,
    'Смотрите передачи родного села с бабушкой и дедушкой',
    (Random()).nextInt(100),
    Colors.purple,
    getGradient(Colors.purple),
  ),
  CardContent(
    'Развлекательные',
    45,
    'То, что надо для отдыха после тяжелого рабочего дня, скучно не будет',
    (Random()).nextInt(100),
    Colors.orange,
    getGradient(Colors.orange),
  ),
  CardContent(
    'Спортивные',
    7,
    'Быстрее. Выше. Сильнее. Добро пожаловать в мир спорта',
    (Random()).nextInt(100),
    Colors.tealAccent,
    getGradient(Colors.tealAccent),
  ),
  CardContent(
    'Детские',
    105,
    'Надоели спиногрызы? Включите им канал из данной категории - мы позаботимся о них',
    (Random()).nextInt(100),
    Colors.yellow,
    getGradient(Colors.yellow),
  ),
  CardContent(
    'Музыкальные',
    25,
    'Моргенчлен, Баста и еще мало знкомые люди ждут Вас',
    (Random()).nextInt(100),
    Colors.green,
    getGradient(Colors.green),
  ),
  CardContent(
    'Новостные',
    12,
    'Будьте вкурсе, кого на этот раз посадили',
    (Random()).nextInt(100),
    Colors.red,
    getGradient(Colors.red),
  ),
  CardContent(
    'Позновательные',
    9,
    'Зашли сюда деградировать? Тогда мотайте дальше',
    (Random()).nextInt(100),
    Colors.pinkAccent,
    getGradient(Colors.pinkAccent),
  ),
  CardContent(
    'Фильмы',
    37,
    'Фильмы, сериалы, аниме, хентай, шутка, сериалов тут нет',
    (Random()).nextInt(100),
    Colors.blueGrey,
    getGradient(Colors.blueGrey),
  ),
  CardContent(
    'Избранные',
    777,
    'Все твои любимые категории в одной, как прекрасно',
    (Random()).nextInt(100),
    Colors.lime,
    getGradient(Colors.lime),
  ),
];

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
  Gradient backgroundGradient = categories[0].cardGradient;

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
        child: WillPopScope(
          onWillPop: () => showExitDialog(context),
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
                  gradient: backgroundGradient
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
                              left: MediaQuery.of(context).size.width * 0.115,
                              right: 20,
                              bottom: MediaQuery.of(context).size.height * 0.05,
                            ),
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                _buttonIcon(Fontisto.search, () {}),
                                _buttonIcon(Fontisto.nav_icon_list_a, () {}),
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
          ),
        )
    );
  }
}

Future<bool> showExitDialog(BuildContext context) async {
  // show the dialog
  return await showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black38,
    transitionDuration: const Duration(milliseconds: 10),
    pageBuilder: (ctx, anim1, anim2) => _buildExitPopup(context),
    transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
      filter: ImageFilter.blur(
          sigmaX: 1 * anim1.value, sigmaY: 1 * anim1.value
      ),
      child: FadeTransition(
        child: child,
        opacity: anim1,
      ),
    ),
    context: context,
  ).then((exit) {
    return exit is bool && exit;
  });
}

Widget _buildExitPopup(BuildContext context) {
  return OrientationBuilder(
      builder: (context, orientation) {
        late double height;
        late double width;

        if (orientation == Orientation.landscape) {
          height = MediaQuery.of(context).size.height * 0.55;
          width = MediaQuery.of(context).size.height * 0.55;
        } else {
          height = MediaQuery.of(context).size.height * 0.3;
          width = MediaQuery.of(context).size.height * 0.3;
        }

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 4.0,
          child: SizedBox(
            height: height,
            width: width,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: <Widget>[
                      Text(
                        'Уже уходите?',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(color: Colors.black),
                      ),
                      const Spacer(),
                      const Icon(Fontisto.confused, color: Colors.black)
                    ],
                  ),
                  const Spacer(),
                  Text(
                    'Может передумаете, у нас печеньки..',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: Colors.black54),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _button('Я передумал', () => Navigator.pop(context, false)),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 10)),
                      Expanded(
                        child: _button('Уйти', () => Navigator.pop(context, true)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
  );
}

Widget _buttonIcon(IconData icon, Function onTap) {
  return InkWell(
    onTap: () => onTap(),
    child: Icon(icon, color: Colors.white),
  );
}

Widget _button(String text, Function onPress) {
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    backgroundColor: Colors.blue,
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
  );
  return TextButton(
    style: flatButtonStyle,
    onPressed: () => onPress(),
    child: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
  );
}