// native
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// application
import 'package:bormental/screens/home/cards.dart';
import 'package:bormental/screens/home/buttons.dart';

// fonts
import 'package:bormental/fonts/fontisto_icons.dart';

class ListScreen extends StatefulWidget {
  final CardContent cardContent;

  const ListScreen({Key? key, required this.cardContent}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> with TickerProviderStateMixin {
  late AnimationController animation;
  late Animation<Offset> offset;
  late ScrollController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = ScrollController();

    animation = AnimationController(
        vsync: this,
        duration: const Duration(
            milliseconds: 1000
        ),
        lowerBound: 0.0,
        upperBound: 1.0
    );

    offset = Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
        .animate(animation);

    animation.forward();
    animation.reverseDuration = const Duration(
        milliseconds: 300
    );
  }

  @override
  void dispose() {
    super.dispose();
    animation.dispose();
  }

  Future<List<String>> getStringList() async {
    try {
      return Future.delayed(const Duration(seconds: 2)).then((value) {
        final List<String> list = [];
        for (var i = 0; i <= 200; i++) {
          list.add('item_$i');
        }
        return list;
      });
    } catch (e) {
      return [];
    }
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
          onWillPop: () async {
            animation.reverse();
            await Future.delayed(const Duration(milliseconds: 300));
            return true;
          },
          child: Stack(
            children: <Widget>[
              Hero(
                tag: widget.cardContent.cardUUID + "_background",
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
              Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 40, bottom: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Hero(
                                tag: widget.cardContent.cardUUID + "_search",
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: buttonIcon(Fontisto.search, Colors.black54, () {}),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Hero(
                                    tag: widget.cardContent.cardUUID + "_title",
                                    child: Text(
                                      widget.cardContent.cardTitle,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          ?.copyWith(color: Colors.black54),
                                    ),
                                  ),
                                  Hero(
                                    tag: widget.cardContent.cardUUID + "_subtitle",
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 4.0),
                                      child: Text(
                                        widget.cardContent.channelsCount,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(color: Colors.grey[500]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Hero(
                                tag: widget.cardContent.cardUUID + "_options",
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: buttonIcon(Fontisto.nav_icon_list_a, Colors.black54, () {}),
                                ),
                              )
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                          ),
                          Hero(
                            tag: widget.cardContent.cardUUID + "_content",
                            child: Material(
                              type: MaterialType.transparency,
                              child: Container(),
                            ),
                          ),
                          FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                  position: offset,
                                  child: FutureBuilder<List<String>>(
                                    future: getStringList(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData && snapshot.data != null) {
                                        return Column(
                                          children: <Widget>[
                                            SizedBox(
                                              height: 400,
                                              child: ListView.builder(
                                                  padding: const EdgeInsets.all(0),
                                                  physics: const BouncingScrollPhysics(),
                                                  controller: _pageController,
                                                  itemCount: snapshot.data?.length,
                                                  itemBuilder: (BuildContext context, int index) {
                                                    return Text(snapshot.data![index]);
                                                  }
                                              ),
                                            ),
                                          ],
                                        );
                                      }

                                      return Container(
                                        color: Colors.green,
                                        width: double.infinity,
                                        height: 500,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            width: MediaQuery.of(context).size.width * 0.9,
                                            height: 100,
                                            color: Colors.amber,
                                          ),
                                        ),
                                      );
                                    },
                                  )
                              )
                          )
                        ],
                      ),
                    ),
                  )
              ),
            ],
          ),
        )
    );
  }
}