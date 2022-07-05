// native
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// fonts
import 'package:bormental/fonts/fontisto_icons.dart';

// application
import 'package:bormental/screens/home/v2/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

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
                  expandedHeight: 220,
                  titleSpacing: 10,
                  backgroundColor: Colors.white,
                  flexibleSpace: Padding(
                    padding: EdgeInsets.only(top: statusBarHeight),
                    child: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      centerTitle: true,
                      background: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          HeaderActionsPanel(),
                          SizedBox(height: 10),
                          UserInformation(),
                        ],
                      ),
                    ),
                  ),
                  centerTitle: true,
                  bottom: const TabBar(
                    physics: BouncingScrollPhysics(),
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
                    labelStyle: TextStyle(
                      fontSize: 14.0,
                    ),
                    tabs: [
                      Tab(text: "Активность"),
                      Tab(text: "Избранное"),
                      Tab(text: "Группы"),
                    ],
                  ),
                )
              ],
              body: const TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Icon(Icons.directions_transit),
                  Icon(Icons.directions_bike),
                  Icon(Icons.directions_bike),
                ],
              )
          ),
        ),
      ),
    );
  }
}

class HeaderActionsPanel extends StatelessWidget {
  const HeaderActionsPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(
                  Fontisto.arrow_left,
                  color: Colors.black,
                  size: 15,
                ),
                color: Colors.grey,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Text(
                "@suxxorz",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.9),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(
            Fontisto.email,
            color: Colors.black,
            size: 16,
          ),
          color: Colors.grey,
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
            Fontisto.bell,
            color: Colors.black,
            size: 15,
          ),
          color: Colors.grey,
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
            Fontisto.ban,
            color: Colors.black,
            size: 15,
          ),
          color: Colors.grey,
          onPressed: () {},
        ),
      ],
    );
  }
}

class UserInformation extends StatelessWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Material(
          child: const CircleAvatar(
            backgroundImage: NetworkImage(
              "https://lh3.googleusercontent.com/ogw/ADea4I5KM87L_DrqXxuVO7xsFWG17sg2y_soXASSX6hS=s83-c-mo",
            ),
            radius: 30,
          ),
          elevation: 2,
          borderRadius: BorderRadius.circular(50),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
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
              const SizedBox(height: 3),
              const Text(
                "Yet Another Software Engineer",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Category(title: "Подписки"),
                  SizedBox(width: 25),
                  Category(title: "Подписчики"),
                  SizedBox(width: 25),
                  Category(title: "Лайки"),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class Category extends StatelessWidget {
  final String title;
  const Category({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {},
      child: Column(
        children: <Widget>[
          Text(
            Random().nextInt(10000).toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
                fontSize: 12,
                color: Colors.grey
            ),
          ),
        ],
      ),
    );
  }
}