import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class EventCardV3 extends StatelessWidget {
  const EventCardV3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              opaque: false,
              transitionDuration: const Duration(milliseconds: 500),
              fullscreenDialog: true,
              pageBuilder: (
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double>
                  secondaryAnimation
                  ) => EventV3Screen(),
            ),
          );
        },
        child: Material(
          color: Colors.white,
          elevation: 2,
          borderRadius: BorderRadius.circular(5),
          child: Stack(
              children: <Widget>[
                Hero(
                  tag: "event_card_v3_background",
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Stack(
                      children: <Widget>[
                        Hero(
                          tag: "event_card_v3_image",
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)
                            ),
                            child: Image.network(
                              "https://www.film.ru/sites/default/files/news/23695478-917046.jpg",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Spacer(),
                            Container(
                                padding: const EdgeInsets.only(right: 60.0),
                                child: Hero(
                                  tag: "event_card_v3_close",
                                  child: Container(),
                                )
                            ),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 20
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const <Widget>[
                          Hero(
                              tag: "event_card_v3_title",
                              child: Material(
                                type: MaterialType.transparency,
                                child: Text("Моана – первая полинезийская принцесса в классическом диснеевском фильме",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black
                                    )
                                ),
                              )
                          ),
                          SizedBox(height: 20),
                          Hero(
                              tag:"event_card_v3_text",
                              child: Material(
                                type: MaterialType.transparency,
                                child: Text("Дочь вождя и упрямый полубог спасают природу от гибели. Странствие по океану с песнями и испытаниями.",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black
                                    )
                                ),
                              )
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ]
          ),
        ),
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;
  final Color color;
  final Color iconColor;

  const CircleButton({
    Key? key,
    required this.onTap,
    required this.iconData,
    required this.color,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 30.0;
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: iconColor, size: 20),
          ),
        ),
      ),
    );
  }
}

class EventV3Screen extends StatefulWidget {
  const EventV3Screen({Key? key}) : super(key: key);
  @override
  _EventV3ScreenState createState() => _EventV3ScreenState();
}

class _EventV3ScreenState extends State<EventV3Screen> {
  late ScrollController _scrollController;

  double paddingTop = 40;
  Color closeColor = Colors.black;
  Color closeBackColor = Colors.white;

  _scrollListener() {
    setState(() {
      if (_scrollController.position.pixels > 0) {
        paddingTop = _scrollController.position.pixels+40;
      }
    });
    if (_scrollController.position.pixels >= 540) {
      setState(() {
        closeColor = Colors.white;
        closeBackColor = Colors.black54;
      });
    } else {
      closeColor = Colors.black;
      closeBackColor = Colors.white;
    }
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
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
        backgroundColor: Colors.white,
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (o) {
            o.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: "event_card_v3_image",
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0)
                        ),
                        child: Image.network(
                          "https://www.film.ru/sites/default/files/news/23695478-917046.jpg",
                          fit: BoxFit.fill,
                          height: 600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 20
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const <Widget>[
                          Hero(
                              tag: "event_card_v3_title",
                              child: Material(
                                type: MaterialType.transparency,
                                child: Text("Моана – первая полинезийская принцесса в классическом диснеевском фильме",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black
                                    )
                                ),
                              )
                          ),
                          SizedBox(height: 20),
                          Hero(
                              tag:"event_card_v3_text",
                              child: Material(
                                type: MaterialType.transparency,
                                child: Text("Дочь вождя и упрямый полубог спасают природу от гибели. Странствие по океану с песнями и испытаниями. \n \n"
                                    "Бесстрашная Моана, дочь вождя маленького племени на острове в Тихом океане, больше всего на свете мечтает о приключениях и решает отправиться в опасное морское путешествие. Вместе с некогда могущественным полубогом Мауи им предстоит пересечь океан, сразиться со страшными чудовищами и разрушить древнее заклятие."
                                    "Бесстрашная Моана, дочь вождя маленького племени на острове в Тихом океане, больше всего на свете мечтает о приключениях и решает отправиться в опасное морское путешествие. Вместе с некогда могущественным полубогом Мауи им предстоит пересечь океан, сразиться со страшными чудовищами и разрушить древнее заклятие."
                                    "Бесстрашная Моана, дочь вождя маленького племени на острове в Тихом океане, больше всего на свете мечтает о приключениях и решает отправиться в опасное морское путешествие. Вместе с некогда могущественным полубогом Мауи им предстоит пересечь океан, сразиться со страшными чудовищами и разрушить древнее заклятие."
                                    "Бесстрашная Моана, дочь вождя маленького племени на острове в Тихом океане, больше всего на свете мечтает о приключениях и решает отправиться в опасное морское путешествие. Вместе с некогда могущественным полубогом Мауи им предстоит пересечь океан, сразиться со страшными чудовищами и разрушить древнее заклятие."
                                    "Бесстрашная Моана, дочь вождя маленького племени на острове в Тихом океане, больше всего на свете мечтает о приключениях и решает отправиться в опасное морское путешествие. Вместе с некогда могущественным полубогом Мауи им предстоит пересечь океан, сразиться со страшными чудовищами и разрушить древнее заклятие."
                                    "Бесстрашная Моана, дочь вождя маленького племени на острове в Тихом океане, больше всего на свете мечтает о приключениях и решает отправиться в опасное морское путешествие. Вместе с некогда могущественным полубогом Мауи им предстоит пересечь океан, сразиться со страшными чудовищами и разрушить древнее заклятие."
                                    "Бесстрашная Моана, дочь вождя маленького племени на острове в Тихом океане, больше всего на свете мечтает о приключениях и решает отправиться в опасное морское путешествие. Вместе с некогда могущественным полубогом Мауи им предстоит пересечь океан, сразиться со страшными чудовищами и разрушить древнее заклятие."
                                    "Бесстрашная Моана, дочь вождя маленького племени на острове в Тихом океане, больше всего на свете мечтает о приключениях и решает отправиться в опасное морское путешествие. Вместе с некогда могущественным полубогом Мауи им предстоит пересечь океан, сразиться со страшными чудовищами и разрушить древнее заклятие."
                                    "Бесстрашная Моана, дочь вождя маленького племени на острове в Тихом океане, больше всего на свете мечтает о приключениях и решает отправиться в опасное морское путешествие. Вместе с некогда могущественным полубогом Мауи им предстоит пересечь океан, сразиться со страшными чудовищами и разрушить древнее заклятие.",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black
                                    )
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Spacer(),
                    Container(
                        padding: EdgeInsets.only(top: paddingTop),
                        child: Hero(
                          tag: "event_card_v3_close",
                          child: CircleButton(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            color: closeBackColor,
                            iconColor: closeColor,
                            iconData: Icons.close,
                          ),
                        )
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
