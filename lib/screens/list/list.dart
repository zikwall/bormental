// native
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

// dependencies
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// application
import 'types.dart';

Widget buildAnimatedChannelList(int now, List<Channel> channels) {
  return AnimationLimiter(
    child: ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: channels.length,
      itemBuilder: (BuildContext context, int index) {
        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 575),
          child: SlideAnimation(
            child: FadeInAnimation(
              child: _buildChannel(context, now, channels[index]),
            ),
          ),
        );
      },
    ),
  );
}

Widget _buildChannel(BuildContext context, int now, Channel channel) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) {
            return Container();
          })
      );
    },
    child: buildChannelListItem(context, now, channel),
  );
}

Widget buildChannelListItem(BuildContext context, int now, Channel item) {
  DateTime start;
  DateTime stop;
  // magic sizes
  double width = MediaQuery.of(context).size.width * 0.55;

  if (MediaQuery.of(context).orientation == Orientation.landscape) {
    width = MediaQuery.of(context).size.width * 0.8;
  }

  final List<Widget> items = <Widget>[
    Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        width: width,
        child: Text(
          item.channelName,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 13.0,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
          ),
        )
    ),
  ];


  final current = item.current;

  start = DateTime.fromMillisecondsSinceEpoch(getMilliseconds(current.currentProgramStart));
  stop = DateTime.fromMillisecondsSinceEpoch(getMilliseconds(current.currentProgramStop));

  items.addAll(
      [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          width: width,
          child: Text(
            current.currentProgram,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 10.0,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        buildTimeline(width, current.currentProgramStop - current.currentProgramStart, now - current.currentProgramStart),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            "${DateFormat('kk:mm').format(start)} - ${DateFormat('kk:mm').format(stop)}",
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 10.0,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ]
  );

  return Container(
    decoration: const BoxDecoration(
        color: Color(0xfff7f7f7),
        borderRadius: BorderRadius.all(Radius.circular(5))
    ),
    margin: const EdgeInsets.only(bottom: 5),
    child: Row(
      children: <Widget>[
        buildNetworkImage(item.channelLogo),
        Container(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ...items,
              ],
            )
        )
      ],
    ),
  );
}

Widget buildTimeline(double width, int current, int total) {
  return Container(
    alignment: Alignment.centerLeft,
    width: width,
    height: 2,
    color: Colors.grey[300],
    child: Container(
        width: width * floatPercent(current, total),
        height: 2,
        color: Colors.black54
    ),
  );
}


Widget buildNetworkImage(String image, {double size: 65}) {
  return Container(
    alignment: Alignment.center,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 0,
      color: Colors.grey[100],
      child: Padding(
          padding: const EdgeInsets.all(5),
          child: Image.network(image, height: size, width: size)
      ),
    ),
  );
}

double floatPercent(int total, int current) {
  return (current / total);
}

enum Times {
  milliseconds,
  microseconds
}

double getSeconds(int value, Times from) {
  if (from == Times.microseconds) {
    return value / 10000;
  }

  if (from == Times.milliseconds) {
    return value / 1000;
  }

  return value.toDouble();
}

int getMilliseconds(int value) {
  return value * 1000;
}

double getNowTimestamp() {
  return getSeconds(DateTime.now().millisecondsSinceEpoch, Times.milliseconds);
}