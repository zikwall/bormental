// native
import 'dart:ui';

import 'package:flutter/material.dart';

class FrostTransition extends AnimatedWidget {
  final Widget child;
  final Animation<double> animation;

  const FrostTransition({
    Key? key,
    required this.animation,
    required this.child
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) => BackdropFilter(
    filter: ImageFilter.blur(sigmaX: animation.value, sigmaY: animation.value),
    child: Container(
      child: child,
    ),
  );
}