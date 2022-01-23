// native
import 'dart:ui';

import 'package:flutter/material.dart';

// fonts
import 'package:bormental/fonts/fontisto_icons.dart';

// application
import 'package:bormental/transitions/slide_left.dart';
import 'package:bormental/screens/profile/screen.dart';

import 'material.dart';
import 'horizontal.dart';
import 'event.dart';

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
  final tabs = [
    const Tab(text: "Рекомендуем"),
    const Tab(text: "Все"),
    const Tab(text: "Популярные"),
    const Tab(text: "Региональные"),
    const Tab(text: "Детям"),
    const Tab(text: "Кино и Сериалы"),
  ];

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

    final boxItemsBuilder = BoxItemBuilder();
    final rectangleItemsBuilder = RectangleItemBuilder();

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
                      ),
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
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  buildHorizontalScroll(context, boxItemsBuilder,
                    'На основе Ваших просмотров',
                    _fakeItems(),
                    onHeaderClick: () {
                      print("click header");
                    },
                  ),
                  buildHorizontalScroll(context, boxItemsBuilder,
                    'Специально для вас',
                    _fakeItems(),
                    headerLeftPrefix: 'Реклама',
                    headerRightIcon: null,
                  ),
                  buildHorizontalScroll(context, boxItemsBuilder,
                    'Рекомендуем',
                    _fakeItems(),
                    onHeaderClick: () {
                      print("click header");
                    },
                  ),
                  buildEventPromo('Не пропустите событие', 'Матрица: Воскрешение', 'Смотрите фантастический боевик Матрица: Воскрешение на Bormental TV с неподражаемым Киану Ривзом',
                    headerImage: 'https://img.championat.com/s/735x490/news/big/z/z/obzor-matrica-4-voskreshenie_1639587558419925185.jpg',
                    actionButtonLabel: 'Смотреть',
                    actionButtonClick: () {

                    }
                  ),
                  buildHorizontalScroll(context, boxItemsBuilder,
                      'Премиум контент',
                      _fakeItems(),
                      onHeaderClick: () {
                        print("click header");
                      },
                      headerSubText: 'Для наших дорогих подписчиков'
                  ),
                  buildHorizontalScroll(context, rectangleItemsBuilder,
                    'Специально для вас',
                    _fakeItems(),
                    headerLeftPrefix: 'Реклама',
                    headerRightIcon: null,
                  ),
                  buildEventPromo('Встречайте новое событие', 'Человек-Паук: Через вселенные', 'Пауки из разных измерений объединяются перед общей угрозой. Изобретательный кинокомикс с «Оскаром» за анимацию',
                      headerImage: 'https://xage.ru/media/posts/2018/6/7/spider-man-spider-verse-trailer-introduces-several-heroes.jpg',
                      actionButtonLabel: 'Подробнее',
                      actionButtonClick: () {

                      }
                  ),
                  buildHorizontalScroll(context, boxItemsBuilder,
                      'Популярные телеканалы',
                      _fakeItems(),
                      onHeaderClick: () {
                        print("click header");
                      },
                  ),
                  buildHorizontalScroll(context, boxItemsBuilder,
                    'Сделано в России',
                    _fakeItems(),
                    onHeaderClick: () {
                      print("click header");
                    },
                    headerSubText: 'Телеканалы Российских поставщиков'
                  ),
                  buildEventPromo('Попробуйте наше новое приложение', 'Bormental Plus++',
                    'Окажитесь в числе счастливчиков и поучавствуйте в Beta-тестировании нашего нового продукта Bormental Plus. Спешите, места ограничены!',
                    actionButtonLabel: 'Хочу учавствовать!',
                    actionButtonClick: () {

                    }
                  ),
                ],
              ),
            ),
            const Icon(Icons.directions_transit),
            const Icon(Icons.directions_bike),
            const Icon(Icons.directions_bike),
            const Icon(Icons.directions_bike),
            const Icon(Icons.directions_bike),
          ],
        )
    );
  }
}

List<BoxItem> _fakeItems() {
  return List<int>.filled(10, 10).map((e) => BoxItem(
    "Title $e", "Subtitle $e", ""
  )).toList();
}