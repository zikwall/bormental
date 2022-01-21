// native
import 'dart:ui';

import 'package:flutter/material.dart';

// fonts
import 'package:bormental/fonts/fontisto_icons.dart';

Future<bool> showExitDialog(BuildContext context) async {
  // show the dialog
  return await showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black38,
    transitionDuration: const Duration(milliseconds: 10),
    pageBuilder: (ctx, anim1, anim2) => _buildExitPopup(context),
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

Widget _buildExitPopup(BuildContext context) {
  return OrientationBuilder(
      builder: (context, orientation) {
        late double height;
        late double width;

        if (orientation == Orientation.landscape) {
          height = MediaQuery.of(context).size.height * 0.55;
          width = MediaQuery.of(context).size.height * 0.55;
        } else {
          height = MediaQuery.of(context).size.height * 0.3;
          width = MediaQuery.of(context).size.height * 0.3;
        }

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 4.0,
          child: SizedBox(
            height: height,
            width: width,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: <Widget>[
                      Text(
                        'Уже уходите?',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(color: Colors.black),
                      ),
                      const Spacer(),
                      const Icon(Fontisto.confused, color: Colors.black)
                    ],
                  ),
                  const Spacer(),
                  Text(
                    'Может передумаете, у нас печеньки..',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: Colors.black54),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _button('Я передумал', () => Navigator.pop(context, false)),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 10)),
                      Expanded(
                        child: _button('Уйти', () => Navigator.pop(context, true)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
  );
}

Widget _button(String text, Function onPress) {
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    backgroundColor: Colors.blue,
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
  );
  return TextButton(
    style: flatButtonStyle,
    onPressed: () => onPress(),
    child: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
  );
}