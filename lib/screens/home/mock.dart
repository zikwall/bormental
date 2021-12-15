// native
import 'dart:math';

import 'package:flutter/material.dart';

// application
import 'types.dart';

final categories = <CardContent>[
  CardContent(
    'Популярные',
    20,
    'Самые просматриваемые каналы по версии пользователей',
    (Random()).nextInt(100),
    Colors.blueAccent,
    getGradient(Colors.blueAccent),
    1,
  ),
  CardContent(
    'Региональные',
    11,
    'Смотрите передачи родного села с бабушкой и дедушкой',
    (Random()).nextInt(100),
    Colors.purple,
    getGradient(Colors.purple),
    2,
  ),
  CardContent(
    'Развлекательные',
    45,
    'То, что надо для отдыха после тяжелого рабочего дня, скучно не будет',
    (Random()).nextInt(100),
    Colors.orange,
    getGradient(Colors.orange),
    3,
  ),
  CardContent(
    'Спортивные',
    7,
    'Быстрее. Выше. Сильнее. Добро пожаловать в мир спорта',
    (Random()).nextInt(100),
    Colors.tealAccent,
    getGradient(Colors.tealAccent),
    4,
  ),
  CardContent(
    'Детские',
    105,
    'Надоели спиногрызы? Включите им канал из данной категории - мы позаботимся о них',
    (Random()).nextInt(100),
    Colors.yellow,
    getGradient(Colors.yellow),
    5,
  ),
  CardContent(
    'Музыкальные',
    25,
    'Моргенчлен, Баста и еще мало знкомые люди ждут Вас',
    (Random()).nextInt(100),
    Colors.green,
    getGradient(Colors.green),
    6,
  ),
  CardContent(
    'Новостные',
    12,
    'Будьте вкурсе, кого на этот раз посадили',
    (Random()).nextInt(100),
    Colors.red,
    getGradient(Colors.red),
    7,
  ),
  CardContent(
    'Позновательные',
    9,
    'Зашли сюда деградировать? Тогда мотайте дальше',
    (Random()).nextInt(100),
    Colors.pinkAccent,
    getGradient(Colors.pinkAccent),
    8,
  ),
  CardContent(
    'Фильмы',
    37,
    'Фильмы, сериалы, аниме, хентай, шутка, сериалов тут нет',
    (Random()).nextInt(100),
    Colors.blueGrey,
    getGradient(Colors.blueGrey),
    9,
  ),
  CardContent(
    'Избранные',
    777,
    'Все твои любимые категории в одной, как прекрасно',
    (Random()).nextInt(100),
    Colors.lime,
    getGradient(Colors.lime),
    10,
  ),
];
