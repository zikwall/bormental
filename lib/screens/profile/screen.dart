import 'dart:math';

// native
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// fonts
import 'package:bormental/fonts/fontisto_icons.dart';

// application
import 'package:bormental/screens/home/v2/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  static Random random = Random();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: NestedScrollView(
              physics: const BouncingScrollPhysics(),
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  elevation: 1,
                  snap: true,
                  floating: true,
                  pinned: true,
                  toolbarHeight: 240,
                  expandedHeight: 210,
                  titleSpacing: 10,
                  backgroundColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    centerTitle: true,
                    background: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(
                                Fontisto.arrow_left,
                                color: Colors.black,
                                size: 15,
                              ),
                              color: Colors.grey,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            const Spacer(),
                            IconButton(
                              icon: Icon(
                                Fontisto.email,
                                color: Colors.black,
                                size: 16,
                              ),
                              color: Colors.grey,
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(
                                Fontisto.bell,
                                color: Colors.black,
                                size: 15,
                              ),
                              color: Colors.grey,
                              onPressed: () {},
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                "https://lh3.googleusercontent.com/ogw/ADea4I5KM87L_DrqXxuVO7xsFWG17sg2y_soXASSX6hS=s83-c-mo",
                              ),
                              radius: 30,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Andrey Kapitonov",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.9),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  const Text(
                                    "Yet Another Software Engineer",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 12
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      _buildCategory("Подписки"),
                                      SizedBox(width: 25),
                                      _buildCategory("Подписчики"),
                                      SizedBox(width: 25),
                                      _buildCategory("Лайки"),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                  centerTitle: true,
                  bottom: TabBar(
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
                    tabs: const [
                      Tab(text: "Активность"),
                      Tab(text: "Избранное"),
                      Tab(text: "Группы"),
                    ],
                  ),
                )
              ],
              body: TabBarView(
                children: [
                  const Icon(Icons.directions_transit),
                  const Icon(Icons.directions_bike),
                  const Icon(Icons.directions_bike),
                ],
              )
          ),
        ),
      ),
    );
  }

  Widget _buildCategory(String title) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {},
      child: Column(
        children: <Widget>[
          Text(
            random.nextInt(10000).toString(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
                fontSize: 12,
                color: Colors.grey
            ),
          ),
        ],
      ),
    );
  }
}