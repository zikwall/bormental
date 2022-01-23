// native
import 'dart:math';
import 'package:flutter/material.dart';
// fonts
import 'package:bormental/fonts/fontisto_icons.dart';
import 'images.dart';

class BoxItem {
  final String title;
  final String subtitle;
  final String image;

  BoxItem(this.title, this.subtitle, this.image);
}

class ItemBuilder {
  double height() {
    throw('Unimplemented');
  }
  Widget build(BoxItem item) {
    throw('Unimplemented');
  }
}

class BoxItemBuilder implements ItemBuilder {
  @override
  Widget build(BoxItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Material(
            elevation: 2,
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  getBoxImg(),
                  height: 80.0,
                  width: 80.0,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(item.title, style: const TextStyle(
              fontSize: 12,
              color: Colors.black
          )),
          const SizedBox(height: 5),
          Text(item.subtitle, style: const TextStyle(
              fontSize: 12,
              color: Colors.black54
          )),
        ],
      ),
    );
  }

  @override
  double height() {
    return 163;
  }
}

class RectangleItemBuilder implements ItemBuilder {
  @override
  Widget build(BoxItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            elevation: 2,
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.network(
                  getRecImg(),
                  height: 90.0,
                  width: 200.0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(5.0),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.network(
                      getBoxImg(),
                      height: 43.0,
                      width: 43.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(item.title, style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black
                  )),
                  const SizedBox(height: 5),
                  Text(item.subtitle, style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54
                  )),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  double height() {
    return 183;
  }
}

Widget buildHorizontalScroll(
    BuildContext context,
    ItemBuilder builder,
    String header,
    List<BoxItem> items,
    // optional arguments
    {
      onHeaderClick,
      onItemClick,
      headerRightIcon: Fontisto.arrow_right,
      headerLeftPrefix,
      headerSubText,
    }
) {
  return Column(
    children: <Widget>[
      InkWell(
        onTap: onHeaderClick,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  if (headerLeftPrefix != null && headerLeftPrefix is String)
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Text(headerLeftPrefix, style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black
                      )),
                    ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(header, style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black
                      )),
                      if (headerSubText != null && headerSubText is String)
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(headerSubText, style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey
                          )),
                        ),
                    ],
                  ),
                ],
              ),
              if (headerRightIcon != null)
                Icon(headerRightIcon, size: 13, color: Colors.black)
            ],
          ),
        ),
      ),
      SizedBox(
        height: builder.height(),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 15),
          scrollDirection: Axis.horizontal,
          children: items.map((item) => InkWell(
            onTap: () {
              if (onItemClick is Function) {
                onItemClick(item);
              }
            },
            borderRadius: BorderRadius.circular(10),
            child: builder.build(item),
          )).toList(),
        ),
      )
    ],
  );
}