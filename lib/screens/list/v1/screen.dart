// native
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

// application
import 'package:bormental/screens/home/v1/types.dart';
import 'package:bormental/screens/home/v1/buttons.dart';
import 'package:bormental/screens/list/v1/list.dart';
import 'package:bormental/screens/list/v1/mock.dart';

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

  @override
  void initState() {
    super.initState();

    animation = AnimationController(
        vsync: this,
        duration: const Duration(
            milliseconds: 1
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
              _buildStackedBackground(widget.cardContent),
              Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 40
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildStackedHeader(context, widget.cardContent),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                        ),
                        _buildStackedFakeContentArea(widget.cardContent),
                        FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                              position: offset,
                              child: _buildContentWrap(context)
                          ),
                        )
                      ],
                    ),
                  )
              ),
            ],
          ),
        )
    );
  }
}

Widget _buildStackedFakeContentArea(CardContent card) {
  return Hero(
    tag: card.cardUUID + "_content",
    child: Material(
      type: MaterialType.transparency,
      child: Container(),
    ),
  );
}

Widget _buildStackedBackground(CardContent card) {
  return Hero(
    tag: card.cardUUID + "_background",
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),
  );
}

Widget _buildStackedHeader(BuildContext context, CardContent card) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Hero(
        tag: card.cardUUID + "_search",
        child: Material(
          type: MaterialType.transparency,
          child: buttonIcon(Fontisto.search, Colors.black54, () {}),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag:card.cardUUID + "_title",
            child: Text(
              card.cardTitle,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: Colors.black54),
            ),
          ),
          Hero(
            tag: card.cardUUID + "_subtitle",
            child: Container(
              margin: const EdgeInsets.only(top: 4.0),
              child: Text(
                card.channelsCount,
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
        tag: card.cardUUID + "_options",
        child: Material(
          type: MaterialType.transparency,
          child: buttonIcon(Fontisto.nav_icon_list_a, Colors.black54, () {}),
        ),
      )
    ],
  );
}

Widget _buildContentWrap(BuildContext context) {
  return Column(
    children: <Widget>[
      SizedBox(
        height: MediaQuery.of(context).orientation == Orientation.landscape
            ? MediaQuery.of(context).size.height * 0.71
            : MediaQuery.of(context).size.height * 0.86,
        child: buildAnimatedChannelList(getNowTimestamp().toInt(), channels),
      ),
    ],
  );
}