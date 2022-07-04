// native
import 'package:flutter/material.dart';

// application
import 'package:bormental/screens/home/v2/event_screen.dart';

Widget buildEventPromo(
    BuildContext context,
    String id,
    String header,
    String textHeader,
    String text,
  {
    actionButtonClick,
    headerImage,
    String actionButtonLabel: 'Подробнее',
  }
) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(
        PageRouteBuilder(
          /// [opaque] set fasle, then the detail page can see the home page screen.
          opaque: false,
          transitionDuration: const Duration(milliseconds: 700),
          fullscreenDialog: true,
          pageBuilder: (context, _, __) => EventScreen(
              id: id, image: headerImage
          ),
          settings: RouteSettings(arguments: id),
        ),
      );
    },
    child:  Padding(
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
          Material(
            color: Colors.white,
            elevation: 2,
            borderRadius: BorderRadius.circular(5),
            child: Column(
              children: <Widget>[
                if (headerImage != null && headerImage is String)
                  Hero(
                    tag: id,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                      child: Image.network(
                        headerImage,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Hero(
                        tag: "${id}_title",
                        child: Text(textHeader, style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black
                        ))
                      ),
                      const SizedBox(height: 20),
                      Hero(
                          tag: "${id}_text",
                          child: Text(text, style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black
                          )),
                      ),
                      if (actionButtonClick != null && actionButtonClick is Function)
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(actionButtonLabel, style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.green
                          )),
                        ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}