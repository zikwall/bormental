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

import 'home.dart';

List<Widget> _screens(BuildContext context) {
  return [
    const HomeScreenV2(),
    const ComingSoon(Fontisto.heart),
    const ComingSoon(Fontisto.film),
    const MenuScreen(),
  ];
}

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
              children: _screens(context),
            ),
            bottomNavigationBar: TitledBottomNavigationBar(
              enableShadow: true,
              reverse: true,
              currentIndex: currentTabIndex,
              backgroundColor: Colors.white,
              indicatorColor: Colors.green,
              inactiveStripColor: Colors.white,
              activeColor: Colors.green,
              inactiveColor: Colors.black,
              onTap: onTapped,
              items: [
                _bottomItem('ТВ', Fontisto.podcast),
                _bottomItem('Избранное', Fontisto.heart),
                _bottomItem('Фильмы', Fontisto.film),
                _bottomItem('Еще', Fontisto.nav_icon_list_a),
              ],
            )
        ),
      ),
    );
  }
}

TitledNavigationBarItem _bottomItem(String title, IconData icon) {
  return TitledNavigationBarItem(
      title: Text(
          title,
          style: const TextStyle(
            color: Colors.green,
            fontSize: 14,
      )),
      icon: icon,
      backgroundColor: Colors.white,
      size: 15
  );
}