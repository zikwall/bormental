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
          'What\'s up?',
          style: Theme.of(context)
              .textTheme
              .headline4
              ?.copyWith(color: Colors.white),
        ),
      ],
    ),
  );
}

Widget buildWhatsUp(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(
      left: MediaQuery.of(context).size.width * 0.13,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'What\'s up?',
          style: Theme.of(context)
              .textTheme
              .headline4
              ?.copyWith(color: Colors.white),
        ),
        Text(
          'Good evening',
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(
              color: Colors.white.withOpacity(0.7)),
        ),
        Container(height: 16.0),
        Text(
          'You have 5 tasks to complete',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(
              color: Colors.white.withOpacity(0.7)),
        ),
        Container(
          height: 16.0,
        )
      ],
    ),
  );
}