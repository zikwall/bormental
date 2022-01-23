import 'package:flutter/material.dart';

class CardContent {
  int id;
  final String title;
  final int channels;
  final String description;
  final int percentage;
  final Color color;
  final LinearGradient gradient;
  final bool isLocked;

  CardContent(this.title, this.channels, this.description, this.percentage, this.color, this.gradient, this.id, this.isLocked);

  String get cardUUID => 'card_${id.toString()}';
  String get channelsCount => 'в категории $channels каналов';
  String get cardTitle => title;
  String get cardDescription => description;
  int get currentPercentage => percentage;
  Color get cardColor => color;
  Gradient get cardGradient => gradient;
  bool get cardIsLocked => isLocked;
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