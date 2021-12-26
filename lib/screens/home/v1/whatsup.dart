// native
import 'package:flutter/material.dart';

Widget buildWhatsUpHorizontal(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(
      left: MediaQuery.of(context).size.width * 0.115,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Hey, What\'s up?',
          style: Theme.of(context)
              .textTheme
              .headline4
              ?.copyWith(color: Colors.white),
        ),
      ],
    ),
  );
}

Widget buildWhatsUp(BuildContext context, int countCategories) {
  return Container(
    margin: EdgeInsets.only(
      left: MediaQuery.of(context).size.width * 0.13,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Hey, What\'s up?',
          style: Theme.of(context)
              .textTheme
              .headline4
              ?.copyWith(color: Colors.white),
        ),
        Container(height: 10.0),
        Padding(
          padding: const EdgeInsets.only(left: 1),
          child: Text(
            'Приятного вечера',
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(
                color: Colors.white.withOpacity(0.7)),
          ),
        ),
        Container(height: 5.0),
        Padding(
          padding: const EdgeInsets.only(left: 1),
          child: Text(
            'В твоей коллекции $countCategories категорий',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(
                color: Colors.white.withOpacity(0.7)),
          ),
        ),
        Container(
          height: 10.0,
        )
      ],
    ),
  );
}