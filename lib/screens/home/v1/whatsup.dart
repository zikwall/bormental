// native
import 'package:flutter/material.dart';

class WhatsUpHorizontal extends StatelessWidget {
  final int countCategories;

  const WhatsUpHorizontal({
    Key? key,
    required this.countCategories
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.115,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Привет, Андрей',
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: Colors.white),
          ),
          Container(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Text(
              'Приятного вечера',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(
                  color: Colors.white),
            ),
          ),
          Container(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Text(
              'В твоей коллекции ${countCategories~/2} категорий из $countCategories',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class WhatsUp extends StatelessWidget {
  final int countCategories;

  const WhatsUp({
    Key? key,
    required this.countCategories
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.13,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Привет, Андрей.',
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: Colors.white),
          ),
          Container(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Text(
              'Приятного вечера',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(
                  color: Colors.white.withOpacity(0.7)),
            ),
          ),
          Container(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Text(
              'В твоей коллекции ${countCategories~/2} категорий из $countCategories',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
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
}