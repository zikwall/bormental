// native
import 'dart:math';
import 'package:flutter/material.dart';

// dependencies
import 'package:intl/intl.dart';

// application
import 'package:bormental/types/channel.dart';
import 'package:bormental/screens/home/v2/images.dart';

class ChannelItem extends StatelessWidget {
  final Channel channel;
  const ChannelItem({Key? key, required this.channel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final current = channel.current;
    /// calculate start & stop of program timeline
    DateTime start = DateTime.fromMillisecondsSinceEpoch(
        ms(current.currentProgramStart)
    );
    DateTime stop = DateTime.fromMillisecondsSinceEpoch(
        ms(current.currentProgramStop)
    );
    /// magic size
    double width = MediaQuery.of(context).size.width - 140;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
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
                  height: 60.0,
                  width: 60.0,
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
              Text(channel.channelName, style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black
              )),
              const SizedBox(height: 5),
              Text(current.currentProgram, style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black
              )),
              const SizedBox(height: 10),
              Timeline(
                width: width,
                current: current.currentProgramStop - current.currentProgramStart,
                total: now().toInt() - current.currentProgramStart,
              ),
              const SizedBox(height: 5),
              Text("${DateFormat('kk:mm').format(start)} - ${DateFormat('kk:mm').format(stop)}",
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54
                  )
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Timeline extends StatelessWidget {
  final double width;
  final int current;
  final int total;

  const Timeline({
    Key? key,
    required this.width,
    required this.current,
    required this.total
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: width,
      height: 2,
      color: Colors.green[100],
      child: Container(
          width: width * floatPercent(current, total),
          height: 2,
          color: Colors.green
      ),
    );
  }
}

// channel
List<Channel> getChannels() {
  return [
    Channel(Current((now() - (Random()).nextInt(1700)).toInt(), (now() + (Random()).nextInt(1700)).toInt(), 'current program description here'), 'Channel 1', ''),
    Channel(Current((now() - (Random()).nextInt(1700)).toInt(), (now() + (Random()).nextInt(1700)).toInt(), 'current program description here'), 'Channel 1', ''),
    Channel(Current((now() - (Random()).nextInt(1700)).toInt(), (now() + (Random()).nextInt(1700)).toInt(), 'current program description here'), 'Channel 1', ''),
    Channel(Current((now() - (Random()).nextInt(1700)).toInt(), (now() + (Random()).nextInt(1700)).toInt(), 'current program description here'), 'Channel 1', ''),
    Channel(Current((now() - (Random()).nextInt(1700)).toInt(), (now() + (Random()).nextInt(1700)).toInt(), 'current program description here'), 'Channel 1', ''),
    Channel(Current((now() - (Random()).nextInt(1700)).toInt(), (now() + (Random()).nextInt(1700)).toInt(), 'current program description here'), 'Channel 1', ''),
    Channel(Current((now() - (Random()).nextInt(1700)).toInt(), (now() + (Random()).nextInt(1700)).toInt(), 'current program description here'), 'Channel 1', ''),
    Channel(Current((now() - (Random()).nextInt(1700)).toInt(), (now() + (Random()).nextInt(1700)).toInt(), 'current program description here'), 'Channel 1', ''),
  ];
}
// time

double floatPercent(int total, int current) {
  return (current / total);
}

enum Times {
  milliseconds,
  microseconds
}

double sec(int value, Times from) {
  if (from == Times.microseconds) {
    return value / 10000;
  }
  if (from == Times.milliseconds) {
    return value / 1000;
  }
  return value.toDouble();
}

int ms(int value) {
  return value * 1000;
}

double now() {
  return sec(DateTime.now().millisecondsSinceEpoch, Times.milliseconds);
}