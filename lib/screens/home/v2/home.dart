// native
import 'dart:ui';
import 'package:flutter/material.dart';

// fonts
import 'package:bormental/fonts/fontisto_icons.dart';

// application
import 'package:bormental/transitions/slide_left.dart';
import 'package:bormental/screens/profile/screen.dart';
import 'package:bormental/screens/home/v2/material.dart';
import 'package:bormental/screens/home/v2/recommendations.dart';
import 'package:bormental/screens/home/v2/all.dart';

const tabs = [
  Tab(text: "Рекомендуем"),
  Tab(text: "Все"),
  Tab(text: "Популярные"),
  Tab(text: "Региональные"),
  Tab(text: "Детям"),
  Tab(text: "Кино и Сериалы"),
];

class HomeScreenV2 extends StatefulWidget {
  const HomeScreenV2({Key? key}) : super(key: key);
  @override
  _HomeScreenV2State createState() => _HomeScreenV2State();
}

class _HomeScreenV2State extends State<HomeScreenV2> with
    SingleTickerProviderStateMixin,
    AutomaticKeepAliveClientMixin<HomeScreenV2>
{
  late TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NestedScrollView(
        physics: const BouncingScrollPhysics(),
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            elevation: 1,
            snap: true,
            floating: true,
            pinned: true,
            toolbarHeight: 70,
            expandedHeight: 120,
            titleSpacing: 30,
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Search(),
                    ),
                  ),
                ),
              ],
            ),
            centerTitle: true,
            bottom: TabBar(
              controller: _tabController,
              padding: const EdgeInsets.only(left: 20),
              physics: const BouncingScrollPhysics(),
              indicator: MaterialIndicator(
                color: Colors.green,
                paintingStyle: PaintingStyle.fill,
              ),
              isScrollable: true,
              indicatorWeight: 3,
              indicatorColor: Colors.green,
              labelColor: Colors.green,
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: const TextStyle(
                fontSize: 14.0,
              ),
              tabs: tabs,
            ),
          )
        ],
        body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            RecommendationsScreen(),
            AllScreen(),
            Icon(Icons.directions_bike),
            Icon(Icons.directions_bike),
            Icon(Icons.directions_bike),
            Icon(Icons.directions_bike),
          ],
        )
    );
  }
}

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        IconButton(
            splashColor: Colors.transparent,
            icon: const Icon(
                Fontisto.search ,
                color: Colors.black,
                size: 15
            ),
            onPressed: () {}
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
                hintText: "Что-то...",
                hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 14
                ),
                border: InputBorder.none),
          ),
        ),
        IconButton(
          splashColor: Colors.transparent,
          icon: const Icon(
              Fontisto.mic,
              color: Colors.black,
              size: 15
          ),
          onPressed: () {},
        ),
        InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
            Navigator.push(
                context, SlideRightToLeftRoute(page: const ProfileScreen()
            ));
          },
          child: const Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 10),
            child: CircleAvatar(
              backgroundImage:
              NetworkImage('https://lh3.googleusercontent.com/ogw/ADea4I5KM87L_DrqXxuVO7xsFWG17sg2y_soXASSX6hS=s32-c-mo'),
              backgroundColor: Colors.transparent,
              radius: 10.0,
            ),
          ),
        )
      ],
    );
  }
}