// native
import 'dart:ui';
import 'package:flutter/material.dart';

// fonts
import 'package:bormental/fonts/fontisto_icons.dart';

Future<bool> showBanPopup(BuildContext context) async {
  // show the dialog
  return await showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black38,
    transitionDuration: const Duration(milliseconds: 10),
    pageBuilder: (ctx, anim1, anim2) => const BanPopup(),
    transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
      filter: ImageFilter.blur(
          sigmaX: 1 * anim1.value, sigmaY: 1 * anim1.value
      ),
      child: FadeTransition(
        child: child,
        opacity: anim1,
      ),
    ),
    context: context,
  ).then((exit) {
    return exit is bool && exit;
  });
}

class BanPopup extends StatelessWidget {
  const BanPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (context, orientation) {
          late double height;
          late double width;
          if (orientation == Orientation.landscape) {
            height = MediaQuery.of(context).size.height * 0.70;
            width = MediaQuery.of(context).size.height * 0.65;
          } else {
            height = MediaQuery.of(context).size.height * 0.36;
            width = MediaQuery.of(context).size.height * 0.36;
          }
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 4.0,
            child: SizedBox(
              height: height,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'You are banned',
                          style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.black),
                        ),
                        const Spacer(),
                        const Icon(Fontisto.dizzy, color: Colors.black)
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: Text(
                        'Bormental recommends removing suspicious apps from your device and trying to restart the app.',
                        style: TextStyle(color: Colors.black54)
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                            ),
                            onPressed: () => () {},
                            child: const Text(
                              'No, thanks',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                            ),
                            onPressed: () => () {},
                            child: const Text(
                              'Okay, I\'ll fix it',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0),
                              ),
                            ),
                            child: Row(
                              children: const <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 16.0),
                                  child: Icon(Fontisto.google_play, color: Colors.black54, size: 13),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Bormental Advisor',
                                    style: TextStyle(
                                        color: Colors.black54
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}

Future<bool> showUpdatePopup(BuildContext context) async {
  // show the dialog
  return await showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black38,
    transitionDuration: const Duration(milliseconds: 10),
    pageBuilder: (ctx, anim1, anim2) => const UpdatePopup(),
    transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
      filter: ImageFilter.blur(
          sigmaX: 1 * anim1.value, sigmaY: 1 * anim1.value
      ),
      child: FadeTransition(
        child: child,
        opacity: anim1,
      ),
    ),
    context: context,
  ).then((exit) {
    return exit is bool && exit;
  });;
}

class UpdatePopup extends StatelessWidget {
  const UpdatePopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (context, orientation) {
          late double height;
          late double width;
          if (orientation == Orientation.landscape) {
            height = MediaQuery.of(context).size.height * 0.70;
            width = MediaQuery.of(context).size.height * 0.65;
          } else {
            height = MediaQuery.of(context).size.height * 0.36;
            width = MediaQuery.of(context).size.height * 0.36;
          }
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 4.0,
            child: SizedBox(
              height: height,
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Update Bormental',
                          style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.black),
                        ),
                        const Spacer(),
                        const Icon(Fontisto.heart_eyes, color: Colors.black)
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: Text(
                        'Bormental recommends updating the app to the latest version. You can continue browsing during the update.',
                        style: TextStyle(color: Colors.black54)
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                            ),
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text(
                              'No, thanks',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                            ),
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text(
                              'Update',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0),
                              ),
                            ),
                            child: Row(
                              children: const <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 16.0),
                                  child: Icon(Fontisto.google_play, color: Colors.black54, size: 13),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Bormental Advisor',
                                    style: TextStyle(
                                        color: Colors.black54
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}