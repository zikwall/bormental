import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

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
          borderRadius: BorderRadius.circular(15),
          child: Stack(
              children: <Widget>[
                Hero(
                  tag: "event_card_v3_background",
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Stack(
                      children: <Widget>[
                        const EventImageHero(
                            image: "https://www.film.ru/sites/default/files/news/23695478-917046.jpg",
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 50, left: 20),
                                  child: Hero(
                                      tag: "event_card_v3_title",
                                      child: Material(
                                        type: MaterialType.transparency,
                                        child: RichText(
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          strutStyle: const StrutStyle(fontSize: 12.0),
                                          text: const TextSpan(
                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
                                              text: 'Моана – первая полинезийская принцесса в классическом диснеевском фильме'),
                                        ),
                                      )
                                  ),
                                )
                            ),
                            Container(
                                padding: const EdgeInsets.only(right: 60.0),
                                child: Hero(
                                  tag: "event_card_v3_close",
                                  child: Container(),
                                )
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 20,
                          child: Hero(
                            tag: "event_card_v3_content",
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: Hero(
                        tag: "event_card_v3_action_footer",
                        child: Material(
                            type: MaterialType.transparency,
                            child: EventRow(
                              image: 'https://i.pinimg.com/564x/90/88/b6/9088b6396e054c5a606d322095e38c46.jpg',
                              title: 'Монана',
                              subtitle: 'Погрузитесь\nв волшебный мир',
                              onAction: () {
                                debugPrint("Watch!");
                              },
                            )
                        ),
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

class EventImageHero extends StatelessWidget {
  final String image;
  final double? height;

  const EventImageHero({
    Key? key,
    required this.image,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "event_card_v3_image",
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15)
        ),
        child: Image.network(image, fit: BoxFit.fill, height: height),
      ),
    );
  }
}

class EventRow extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final Function? onAction;

  const EventRow({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
    this.onAction
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(image,
                height: 50.0,
                width: 50.0,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: const TextStyle(color: Colors.black)),
                RichText(
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  strutStyle: const StrutStyle(fontSize: 12.0),
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black54),
                    text: subtitle,
                  ),
                ),
              ],
            ),
          ],
        ),
        InkWell(
          onTap: () => {
            if (onAction != null) {
              onAction!()
            }
          },
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200]
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10
            ),
            child: const Text('Хочу смотреть!',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class EventContent extends StatelessWidget {
  final Widget? child;
  const EventContent({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const Hero(
            tag:"event_card_v3_content",
            child: Material(
              type: MaterialType.transparency,
              child: Text("Дочь вождя и упрямый полубог спасают природу от гибели. Странствие по океану с песнями и испытаниями. \n \n"
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
          if (child != null)
            child!,
        ],
      ),
    );
  }
}

const List<Map<String, String>> moreItems = [
  {
    'image': 'https://img.kupigolos.ru/hero/5cd9df5c3ae81.jpg?p=bh&s=1f7b4b47fb62358802680b4df0f626c3',
    'title': 'Рапунцель',
    'subtitle': 'Для всей семьи',
  },
  {
    'image': 'https://1001puzzle.ru/upload/iblock/e33/vrvz77o70wer0eg1uimjzha7z7z27uux/32626.jpg',
    'title': 'Аладдин',
    'subtitle': 'Аррабская ннночь!',
  },
  {
    'image': 'https://img4.labirint.ru/rc/80b7430e92df0deb085101e40c11a365/363x561q80/books37/366844/cover.jpg?1563696455',
    'title': 'Король лев',
    'subtitle': 'Ты не мог не плакать!',
  },
  {
    'image': 'https://img.kupigolos.ru/hero/5cd9df5c3ae81.jpg?p=bh&s=1f7b4b47fb62358802680b4df0f626c3',
    'title': 'Рапунцель',
    'subtitle': 'Для всей семьи',
  },
  {
    'image': 'https://img.kupigolos.ru/hero/5cd9df5c3ae81.jpg?p=bh&s=1f7b4b47fb62358802680b4df0f626c3',
    'title': 'Рапунцель',
    'subtitle': 'Для всей семьи',
  },
];

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
                    const EventImageHero(
                      image: "https://www.film.ru/sites/default/files/news/23695478-917046.jpg",
                      height: 600
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.grey.shade200),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        child: Hero(
                          tag: "event_card_v3_action_footer",
                          child: Material(
                              type: MaterialType.transparency,
                              child: EventRow(
                                image: 'https://i.pinimg.com/564x/90/88/b6/9088b6396e054c5a606d322095e38c46.jpg',
                                title: 'Монана',
                                subtitle: 'Погрузитесь\nв волшебный мир',
                                onAction: () {
                                  debugPrint("Watch!");
                                },
                              )
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    EventContent(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Container(
                          padding: const EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 1.0, color: Colors.grey.shade200),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text('Думаю Вам понравится',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 15),
                              ListView.separated(
                                shrinkWrap: true,
                                itemCount: moreItems.length,
                                separatorBuilder: (context, index) {
                                  return const Divider();
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return EventRow(
                                    image: moreItems[index]['image'].toString(),
                                    title: moreItems[index]['title'].toString(),
                                    subtitle: moreItems[index]['subtitle'].toString()
                                  );
                                }
                              ),
                            ],
                          ),
                        ),
                      )
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                        child: Padding(
                            padding: const EdgeInsets.only(top: 50, left: 20),
                            child: Hero(
                                tag: "event_card_v3_title",
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: RichText(
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    strutStyle: const StrutStyle(fontSize: 12.0),
                                    text: const TextSpan(
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
                                      text: 'Моана – первая полинезийская принцесса в классическом диснеевском фильме'),
                                  ),
                                )
                            ),
                        )
                    ),
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
