// native
import 'package:flutter/material.dart';

// application
import 'package:bormental/screens/home/v2/event_screen.dart';

class EventPromo extends StatelessWidget {
  final String id;
  final String header;
  final String title;
  final String text;
  final String? image;
  final String? button;

  const EventPromo({
    Key? key,
    required this.id,
    required this.header,
    required this.title,
    required this.text,
    this.image,
    this.button,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Text(header, style: const TextStyle(
                fontSize: 16,
                color: Colors.black
            )),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (
                      BuildContext context,
                      Animation<double> animation,
                      Animation<double>
                      secondaryAnimation
                  ) => EventScreen(
                      id: id, image: image ?? '', text: text, title: title
                  ),
                ),
              );
            },
            child:  Material(
              color: Colors.white,
              elevation: 2,
              borderRadius: BorderRadius.circular(5),
              child: Column(
                children: <Widget>[
                  if (image != null && image is String)
                    Hero(
                      tag: id,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)
                        ),
                        child: Image.network(
                          image!,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Hero(
                            tag: "${id}_title",
                            child: Material(
                              type: MaterialType.transparency,
                              child: Text(title,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black
                                  )
                              ),
                            )
                        ),
                        const SizedBox(height: 20),
                        Hero(
                            tag: "${id}_text",
                            child: Material(
                              type: MaterialType.transparency,
                              child: Text(text,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black
                                  )
                              ),
                            )
                        ),
                        if (button != null && button is Function)
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(button!,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.green
                                )
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}