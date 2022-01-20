// native
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// dependencies

// fonts
import 'package:bormental/fonts/fontisto_icons.dart';

// application
import 'material.dart';
import 'package:bormental/screens/home/v1/exit.dart';

class HomeScreenV2 extends StatefulWidget {
  const HomeScreenV2({Key? key}) : super(key: key);

  @override
  _HomeScreenV2State createState() => _HomeScreenV2State();
}

class _HomeScreenV2State extends State<HomeScreenV2> {
  @override
  void initState() {
    super.initState();
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
        onWillPop: () {
          FocusScope.of(context).unfocus();
          return showExitDialog(context);
        },
        child: DefaultTabController(
          length: 7,
          child: Scaffold(
            body: NestedScrollView(
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
                    titleSpacing: 10,
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
                              child: Row(
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
                                          hintText: "Type Something...",
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
                                        Fontisto.podcast,
                                        color: Colors.black,
                                        size: 15
                                    ),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    splashColor: Colors.transparent,
                                    icon: const Icon(
                                        Fontisto.home,
                                        color: Colors.black,
                                        size: 15
                                    ),
                                    onPressed: () {},
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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
                        Tab(text: "screen1"),
                        Tab(text: "screen2"),
                        Tab(text: "screen3"),
                        Tab(text: "screen4"),
                        Tab(text: "screen5"),
                        Tab(text: "screen6"),
                        Tab(text: "screen7"),
                      ],
                    ),
                  )
                ],
                body: TabBarView(
                  children: [
                    _buildScrollPage(),
                    const Icon(Icons.directions_transit),
                    const Icon(Icons.directions_bike),
                    const Icon(Icons.directions_bike),
                    const Icon(Icons.directions_bike),
                    const Icon(Icons.directions_bike),
                    const Icon(Icons.directions_bike),
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildScrollPage() {
  final List<Widget> widgets = [];
  for (var i = 0; i <= 10; i++) {
    widgets.add(Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        color: Colors.white,
      ),
      height: 100,
      width: 150,
    ));
    widgets.add(const Padding(padding: EdgeInsets.only(top: 10)));
  }

  return ListView(
    physics: const BouncingScrollPhysics(),
    children: widgets,
  );
}