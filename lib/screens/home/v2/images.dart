import 'dart:math';

const images = <String>[
  'https://toplogos.ru/images/thumbs/preview-logo-unikum.png',
  'https://toplogos.ru/images/thumbs/preview-logo-paramount-channel.png',
  'https://toplogos.ru/images/thumbs/preview-logo-amedia-premium.png',
  'https://toplogos.ru/images/thumbs/preview-logo-78.png',
  'https://toplogos.ru/images/thumbs/preview-logo-kinohit.png',
  'https://toplogos.ru/images/thumbs/preview-logo-nashe-novoe-kino.png',
  'https://toplogos.ru/images/thumbs/preview-logo-kinopremera.png',
  'https://toplogos.ru/images/thumbs/preview-logo-mir-24.png',
  'https://toplogos.ru/images/thumbs/preview-logo-tnt4.png',
  'https://toplogos.ru/images/thumbs/preview-logo-belarus-24.png',
  'https://toplogos.ru/images/thumbs/preview-logo-comedy-club.jpg',
  'https://toplogos.ru/images/thumbs/preview-logo-pyatuyi-kanal.png',
  'https://toplogos.ru/images/thumbs/preview-logo-perviy-kanal.jpg',
  'https://toplogos.ru/images/thumbs/preview-logo-ntv.png',
  'https://toplogos.ru/images/thumbs/preview-logo-ren-tv.png',
];

const imagesRec = <String>[
  'https://toplogos.ru/images/thumbs/preview-logo-bbc.jpg',
  'https://toplogos.ru/images/thumbs/preview-logo-2x2.jpg',
  'https://toplogos.ru/images/thumbs/preview-logo-domashniy.png',
  'https://toplogos.ru/images/thumbs/preview-logo-rossiya-k.jpg',
  'https://toplogos.ru/images/thumbs/preview-logo-kinosemya.png',
  'https://toplogos.ru/images/thumbs/preview-logo-sts-love.png',
  'https://toplogos.ru/images/thumbs/preview-logo-europa-plus-tv.png',
  'https://toplogos.ru/images/thumbs/preview-logo-rodnoe-kino.png',
];

final _random = Random();

String getBoxImg() {
  return images[_random.nextInt(images.length)];
}

String getRecImg() {
  return imagesRec[_random.nextInt(imagesRec.length)];
}