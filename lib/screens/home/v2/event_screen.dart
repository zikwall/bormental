import 'dart:async';
import 'package:flutter/material.dart';

// ignore: constant_identifier_names
const SCALE_ANIMATION_STANDARD = 100;
// ignore: constant_identifier_names
const POP_STANDARD = 130;

class EventScreen extends StatefulWidget {
  final String id;
  final String image;
  final String title;
  final String text;

  const EventScreen({Key? key,
    required this.id,
    required this.image,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> with TickerProviderStateMixin {
  late AnimationController animation;
  late Animation<Offset> offset;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
        vsync: this,
        duration: const Duration(
            milliseconds: 500
        ),
        lowerBound: 0.0,
        upperBound: 1.0
    );

    offset = Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
        .animate(animation);

    animation.forward();
    animation.reverseDuration = const Duration(
        milliseconds: 300
    );
  }

  @override
  void dispose() {
    super.dispose();
    animation.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        animation.reverse();
        await Future.delayed(const Duration(milliseconds: 300));
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: CustomScrollView(
            slivers: <Widget>[
              if (widget.image != '')
                ImageSilver(id: widget.id, image: widget.image),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 50, bottom: 30
                      ),
                      child: ContentSilver(
                          id: widget.id,
                          title: widget.title,
                          text: widget.text,
                          animation: animation,
                          offset: offset
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContentSilver extends StatelessWidget {
  final String id;
  final String title;
  final String text;
  final AnimationController animation;
  final Animation<Offset> offset;

  const ContentSilver({
    Key? key,
    required this.id,
    required this.title,
    required this.text,
    required this.animation,
    required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Hero(
          tag: "${id}_title",
          child: Material(
            type: MaterialType.transparency,
            child: Text(title, style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.black
            )),
          ),
        ),
        const SizedBox(height: 30),
        Hero(
          tag: "${id}_text",
          child: Material(
            type: MaterialType.transparency,
            child: Text(text, style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black
            )),
          ),
        ),
        const SizedBox(height: 30),
        FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: offset,
            child: Text(_text, style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black
            )),
          ),
        )
      ],
    );
  }

  final String _text =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod '
      'tempor incididunt ut labore et dolore magna aliqua. Vulputate dignissim '
      'suspendisse in est. Ut ornare lectus sit amet. Eget nunc lobortis mattis '
      'aliquam faucibus purus in. Hendrerit gravida rutrum quisque non tellus '
      'orci ac auctor. Mattis aliquam faucibus purus in massa. Tellus rutrum '
      'tellus pellentesque eu tincidunt tortor. Nunc eget lorem dolor sed. Nulla '
      'at volutpat diam ut venenatis tellus in metus. Tellus cras adipiscing enim '
      'eu turpis. Pretium fusce id velit ut tortor. Adipiscing enim eu turpis '
      'egestas pretium. Quis varius quam quisque id. Blandit aliquam etiam erat '
      'velit scelerisque. In nisl nisi scelerisque eu. Semper risus in hendrerit '
      'gravida rutrum quisque. Suspendisse in est ante in nibh mauris cursus '
      'mattis molestie. Adipiscing elit duis tristique sollicitudin nibh sit '
      'amet commodo nulla. Pretium viverra suspendisse potenti nullam ac tortor '
      'vitae.\n'
      'velit scelerisque. In nisl nisi scelerisque eu. Semper risus in hendrerit '
      'egestas pretium. quis varius quam quisque id. blandit aliquam etiam erat '
      'gravida rutrum quisque. suspendisse in est ante in nibh mauris cursus '
      'mattis molestie. adipiscing elit duis tristique sollicitudin nibh sit '
      'amet commodo nulla. pretium viverra suspendisse potenti nullam ac tortor '
      'vitae.\n'
      'amet commodo nulla. Pretium viverra suspendisse potenti nullam ac tortor '
      'vitae.\n'
      'velit scelerisque. In nisl nisi scelerisque eu. Semper risus in hendrerit '
      'egestas pretium. quis varius quam quisque id. blandit aliquam etiam erat '
      'gravida rutrum quisque. suspendisse in est ante in nibh mauris cursus '
      'mattis molestie. adipiscing elit duis tristique sollicitudin nibh sit '
      'amet commodo nulla. pretium viverra suspendisse potenti nullam ac tortor '
      'vitae.\n'
      'tempor incididunt ut labore et dolore magna aliqua. Vulputate dignissim '
      'suspendisse in est. Ut ornare lectus sit amet. Eget nunc lobortis mattis '
      'aliquam faucibus purus in. Hendrerit gravida rutrum quisque non tellus '
      'orci ac auctor. Mattis aliquam faucibus purus in massa. Tellus rutrum '
      'tellus pellentesque eu tincidunt tortor. Nunc eget lorem dolor sed. Nulla '
      'at volutpat diam ut venenatis tellus in metus. Tellus cras adipiscing enim '
      'eu turpis. Pretium fusce id velit ut tortor. Adipiscing enim eu turpis '
      'egestas pretium. Quis varius quam quisque id. Blandit aliquam etiam erat '
      'velit scelerisque. In nisl nisi scelerisque eu. Semper risus in hendrerit '
      'gravida rutrum quisque. Suspendisse in est ante in nibh mauris cursus '
      'mattis molestie. Adipiscing elit duis tristique sollicitudin nibh sit '
      'amet commodo nulla. Pretium viverra suspendisse potenti nullam ac tortor '
      'vitae.\n'
      'velit scelerisque. In nisl nisi scelerisque eu. Semper risus in hendrerit '
      'egestas pretium. quis varius quam quisque id. blandit aliquam etiam erat '
      'gravida rutrum quisque. suspendisse in est ante in nibh mauris cursus '
      'mattis molestie. adipiscing elit duis tristique sollicitudin nibh sit '
      'amet commodo nulla. pretium viverra suspendisse potenti nullam ac tortor '
      'vitae.\n'
      'amet commodo nulla. Pretium viverra suspendisse potenti nullam ac tortor '
      'vitae.\n'
      'velit scelerisque. In nisl nisi scelerisque eu. Semper risus in hendrerit '
      'egestas pretium. quis varius quam quisque id. blandit aliquam etiam erat '
      'gravida rutrum quisque. suspendisse in est ante in nibh mauris cursus '
      'mattis molestie. adipiscing elit duis tristique sollicitudin nibh sit '
      'amet commodo nulla. pretium viverra suspendisse potenti nullam ac tortor '
      'vitae.\n';
}

class ImageSilver extends StatelessWidget {
  final String id;
  final String image;

  const ImageSilver({
    Key? key,
    required this.id,
    required this.image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      // hide the back button
      leading: Container(),
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: id,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.network(image, fit: BoxFit.cover, height: 300),
          ),
        ),
      ),
    );
  }
}