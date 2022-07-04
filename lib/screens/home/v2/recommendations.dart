// native
import 'package:flutter/material.dart';

// application
import 'horizontal.dart';
import 'event.dart';

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
      print("REFRESH RECOMMENDATIONS");
      setState(() {

      });
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
            buildEventPromo(context, '1', 'Не пропустите событие', 'Матрица: Воскрешение', 'Смотрите фантастический боевик Матрица: Воскрешение на Bormental TV с неподражаемым Киану Ривзом',
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
            buildEventPromo(context, '2', 'Встречайте новое событие', 'Человек-Паук: Через вселенные', 'Пауки из разных измерений объединяются перед общей угрозой. Изобретательный кинокомикс с «Оскаром» за анимацию',
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
            buildEventPromo(context, '3', 'Попробуйте наше новое приложение', 'Bormental Plus++',
                'Окажитесь в числе счастливчиков и поучавствуйте в Beta-тестировании нашего нового продукта Bormental Plus. Спешите, места ограничены!',
                actionButtonLabel: 'Хочу учавствовать!',
                actionButtonClick: () {

                }
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