// native
import 'package:flutter/material.dart';

// fonts
import 'package:bormental/fonts/fontisto_icons.dart';

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
  final String title;
  final int channels;
  final String description;
  final int percentage;

  CardContent(this.title, this.channels, this.description, this.percentage);

  String get channelsCount => 'в категории $channels каналов';
  String get cardTitle => title;
  String get cardDescription => description;
  int get currentPercentage => percentage;
}

Widget buildCardCategory(BuildContext context, CardContent card) {
  return GestureDetector(
    onTap: () {
      //
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              card.cardTitle,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: Colors.black54),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4.0),
              child: Hero(
                tag: "hero",
                child: Text(
                  card.channelsCount,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Colors.grey[500]),
                ),
              ),
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
            _buildProgressIndicator(context, card.percentage),
          ],
        ),
      ),
    ),
  );
}

Widget _buildProgressIndicator(BuildContext context, progress) {
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
                  color: Colors.blue,
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