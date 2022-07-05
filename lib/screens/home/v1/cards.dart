// native
import 'package:flutter/material.dart';

// fonts
import 'package:bormental/fonts/fontisto_icons.dart';
import 'package:bormental/screens/list/v1/screen.dart';

// application
import 'package:bormental/screens/home/v1/buttons.dart';
import 'package:bormental/screens/home/v1/types.dart';

class CardNew extends StatelessWidget {
  const CardNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class CardCategory extends StatelessWidget {
  final CardContent card;
  const CardCategory({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Hero(
                        tag: card.cardUUID + "_title",
                        child: Text(
                          card.cardTitle,
                          style: Theme.of(context).textTheme.headline5?.copyWith(color: card.cardColor),
                        ),
                      ),
                      if (card.isLocked)
                        Icon(Fontisto.locked, color: card.cardColor, size: 14)
                    ],
                  ),
                  Hero(
                    tag: card.cardUUID + "_subtitle",
                    child: Container(
                      margin: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        card.channelsCount,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(color: card.cardColor),
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
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.black54)
                  ),
                  const Spacer(),
                  CardProgressIndicator(
                      progress: card.percentage,
                      color: card.color
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

const _height = 3.0;

class CardProgressIndicator extends StatelessWidget {
  final int progress;
  final Color color;

  const CardProgressIndicator({
    Key? key,
    required this.progress,
    required this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}