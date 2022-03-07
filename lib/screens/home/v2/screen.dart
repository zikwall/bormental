// native
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// fonts
import 'package:bormental/fonts/fontisto_icons.dart';

// application
import 'package:bormental/components/bottom/navigation_bar.dart';
import 'package:bormental/components/bottom/navigation_bar_item.dart';
import 'package:bormental/components/modals/exit.dart';

// screens
import 'package:bormental/components/comming/comming_soon.dart';
import 'package:bormental/screens/menu/screen.dart';
import 'package:bormental/screens/movie/v1/screen.dart';

import 'home.dart';

class Screen {
  final Widget screen;
  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;
  final bool useShadow;

  Screen(this.screen, this.activeColor, this.backgroundColor, this.useShadow, this.inactiveColor);
}

final List<Screen> _screens = [
  Screen(
    const HomeScreenV2(),
    Colors.green,
    Colors.white,
    true,
    Colors.black,
  ),
  Screen(
    const ComingSoon(Fontisto.heart),
    Colors.green,
    Colors.white,
    true,
    Colors.black,
  ),
  Screen(
    const MovieScreen(),
    const Color(0xffe11d24),
    Colors.black,
    false,
    Colors.white,
  ),
  Screen(
    const MenuScreen(),
    Colors.green,
    Colors.white,
    true,
    Colors.black,
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  // initializes
  late PageController _pageController;

  // states
  int currentTabIndex = 0;

  void onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentTabIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: WillPopScope(
        onWillPop: () {
          FocusScope.of(context).unfocus();
          return showExitDialog(context);
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            // maybe use, but it has performance issue.
            // IndexedStack loads all tab initially which is unnecessary
            // body: IndexedStack(
            //   children: ,
            //   index: currentTabIndex,
            // ),
            body: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _screens.map((Screen screen) => screen.screen).toList(),
            ),
            bottomNavigationBar: TitledBottomNavigationBar(
              enableShadow: _screens[currentTabIndex].useShadow,
              reverse: _screens[currentTabIndex].useShadow,
              currentIndex: currentTabIndex,
              backgroundColor: _screens[currentTabIndex].backgroundColor,
              indicatorColor: _screens[currentTabIndex].activeColor,
              inactiveStripColor: _screens[currentTabIndex].backgroundColor,
              activeColor: _screens[currentTabIndex].activeColor,
              inactiveColor: _screens[currentTabIndex].inactiveColor,
              onTap: onTapped,
              items: [
                _item(
                    'ТВ',
                    Fontisto.podcast,
                    _screens[currentTabIndex].activeColor
                ),
                _item(
                    'Избранное',
                    Fontisto.heart,
                    _screens[currentTabIndex].activeColor
                ),
                _item(
                    'Фильмы',
                    Fontisto.film,
                    _screens[currentTabIndex].activeColor
                ),
                _item(
                    'Еще',
                    Fontisto.nav_icon_list_a,
                    _screens[currentTabIndex].activeColor
                ),
              ],
            )
        ),
      ),
    );
  }
}

TitledNavigationBarItem _item(String title, IconData icon, Color fontColor) {
  return TitledNavigationBarItem(
    title: Text(title, style: TextStyle(color: fontColor, fontSize: 14)),
    icon: icon,
    size: 15,
    backgroundColor: Colors.transparent,
  );
}