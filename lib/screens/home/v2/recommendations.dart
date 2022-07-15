// native
import 'package:flutter/material.dart';

// application
import 'package:bormental/helpers/platform.dart';
import 'package:bormental/screens/home/v2/horizontal.dart';
import 'package:bormental/screens/home/v2/event.dart';
import 'package:bormental/screens/home/v2/event_2.dart';
import 'package:bormental/screens/home/v2/event_3.dart';

final boxItemsBuilder = BoxItemBuilder();
final rectangleItemsBuilder = RectangleItemBuilder();

class RecommendationsScreen extends StatefulWidget {
  const RecommendationsScreen({Key? key}) : super(key: key);
  @override
  _RecommendationsScreenState createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> with AutomaticKeepAliveClientMixin<RecommendationsScreen> {
  final refreshKey = GlobalKey<RefreshIndicatorState>();
  bool fireUpdateTransaction = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future updateState() {
    return Future.delayed(const Duration(milliseconds: 1500), () {
      debugPrint("REFRESH RECOMMENDATIONS");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      key: refreshKey,
      color: Colors.green,
      onRefresh: () {
        return updateState();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            HorizontalScroll(
                builder: boxItemsBuilder,
                header: 'На основе Ваших просмотров',
                items: _fakeItems(),
                onHeaderClick: () {
                  debugPrint("click header");
                },
            ),
            HorizontalScroll(
              builder: boxItemsBuilder,
              header: 'Специально для вас',
              items: _fakeItems(),
              headerLeftPrefix: 'Реклама',
              headerRightIcon: null,
            ),
            HorizontalScroll(
              builder: boxItemsBuilder,
              header: 'Рекомендуем',
              items: _fakeItems(),
              onHeaderClick: () {
                debugPrint("click header");
              },
            ),
            const EventPromo(
              id: '1',
              header: 'Не пропустите событие',
              title: 'Матрица: Воскрешение',
              text:   'Смотрите фантастический боевик Матрица: Воскрешение на Bormental TV с неподражаемым Киану Ривзом',
              button: 'Смотреть',
              image: 'https://img.championat.com/s/735x490/news/big/z/z/obzor-matrica-4-voskreshenie_1639587558419925185.jpg',
            ),
            HorizontalScroll(
              builder: boxItemsBuilder,
              header: 'Премиум контент',
              items: _fakeItems(),
              onHeaderClick: () {
                debugPrint("click header");
              },
              headerSubText: 'Для наших дорогих подписчиков'
            ),
            HorizontalScroll(
              builder: rectangleItemsBuilder,
              header: 'Специально для вас',
              items: _fakeItems(),
              headerLeftPrefix: 'Реклама',
              headerRightIcon: null,
            ),
            const EventPromo(
              id: '2',
              header: 'Встречайте новое событие',
              title: 'Человек-Паук: Через вселенные',
              text:   'Пауки из разных измерений объединяются перед общей угрозой. Изобретательный кинокомикс с «Оскаром» за анимацию',
              button: 'Подробнее',
              image: 'https://xage.ru/media/posts/2018/6/7/spider-man-spider-verse-trailer-introduces-several-heroes.jpg',
            ),
            HorizontalScroll(
              builder: boxItemsBuilder,
              header: 'Популярные телеканалы',
              items: _fakeItems(),
              onHeaderClick: () {
                debugPrint("click header");
              },
            ),
            EventCardV3(),
            HorizontalScroll(
              builder: boxItemsBuilder,
              header: 'Сделано в России',
              items: _fakeItems(),
              onHeaderClick: () {
                debugPrint("click header");
              },
              headerSubText: 'Телеканалы Российских поставщиков'
            ),
            const EventPromo(
              id: '3',
              header: 'Попробуйте наше новое приложение',
              title: 'Bormental Plus++',
              text:  'Окажитесь в числе счастливчиков и поучавствуйте в Beta-тестировании нашего нового продукта Bormental Plus. Спешите, места ограничены!',
              button: 'Хочу учавствовать!',
            ),
          ],
        ),
      ),
    );
  }
}

List<BoxItem> _fakeItems() {
  return List<int>.filled(10, 10).map((e) => BoxItem(
      "Title $e", "Subtitle $e", ""
  )).toList();
}