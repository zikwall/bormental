// native
import 'package:flutter/material.dart';

// fonts
import 'package:bormental/fonts/fontisto_icons.dart';
import 'package:bormental/screens/list/screen.dart';

// application
import 'buttons.dart';

Widget buildCardNew(BuildContext context) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    elevation: 5.0,
    margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
    child: Material(
      borderRadius: BorderRadius.circular(16.0),
      color: Colors.white,
      child: InkWell(
        onTap: () {
          //
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add,
                size: 52.0,
                color: Colors.black,
              ),
              Container(
                height: 8.0,
              ),
              const Text(
                'Add Category',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class CardContent {
  int id;
  final String title;
  final int channels;
  final String description;
  final int percentage;
  final Color color;
  final LinearGradient gradient;

  CardContent(this.title, this.channels, this.description, this.percentage, this.color, this.gradient, this.id);

  String get cardUUID => 'card_${id.toString()}';
  String get channelsCount => 'в категории $channels каналов';
  String get cardTitle => title;
  String get cardDescription => description;
  int get currentPercentage => percentage;
  Color get cardColor => color;
  Gradient get cardGradient => gradient;
}

LinearGradient getGradient(Color color) {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: const [0.3, 0.5, 0.7, 0.9],
    colors: getColorList(color),
  );
}

List<Color> getColorList(Color color) {
  if (color is MaterialColor) {
    return [
      color.shade300,
      color.shade600,
      color.shade700,
      color.shade900,
    ];
  } else {
    return List<Color>.filled(4, color);
  }
}

Widget buildCardCategory(BuildContext context, CardContent card) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double>
              secondaryAnimation
          ) => ListScreen(cardContent: card),
        ),
      );
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Hero(
            tag: card.cardUUID + "_background",
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Hero(
                  tag: card.cardUUID + "_title",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Hero(
                      tag: card.cardUUID + "_search",
                      child: Material(
                        type: MaterialType.transparency,
                        child: SizedBox(
                          height: 0,
                          width: 0,
                          child: buttonIcon(Fontisto.search, Colors.transparent, () {}),
                        ),
                      ),
                    ),
                    Hero(
                      tag: card.cardUUID + "_options",
                      child: Material(
                        type: MaterialType.transparency,
                        child: SizedBox(
                          height: 0,
                          width: 0,
                          child: buttonIcon(Fontisto.search, Colors.transparent, () {}),
                        ),
                      ),
                    )
                  ],
                ),
                const Spacer(
                  flex: 7,
                ),
                Text(
                    card.cardDescription,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: Colors.black54)
                ),
                const Spacer(),
                _buildProgressIndicator(context, card.percentage, card.color),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget _buildProgressIndicator(BuildContext context, progress, color) {
  const _height = 3.0;
  return Row(
    children: [
      Expanded(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Stack(
              children: [
                Container(
                  height: _height,
                  color: Colors.grey.withOpacity(0.1),
                ),
                AnimatedContainer(
                  height: _height,
                  width: (progress / 100) * constraints.maxWidth,
                  color: color,
                  duration: const Duration(milliseconds: 300),
                ),
              ],
            );
          },
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 8.0),
        child: Text(
          "$progress%",
          style: Theme.of(context).textTheme.caption,
        ),
      )
    ],
  );
}