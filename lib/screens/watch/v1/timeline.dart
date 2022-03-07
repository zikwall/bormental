// native
import 'package:flutter/material.dart';

List<_TimelineStatus> data = [
  _TimelineStatus.inProgress,
  _TimelineStatus.inProgress,
  _TimelineStatus.inProgress,
  _TimelineStatus.inProgress,
  _TimelineStatus.inProgress,
  _TimelineStatus.inProgress,
  _TimelineStatus.inProgress,
  _TimelineStatus.inProgress,
  _TimelineStatus.inProgress,
  _TimelineStatus.todo,
  _TimelineStatus.todo,
  _TimelineStatus.todo,
  _TimelineStatus.todo,
];

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

Widget timeline() {
  return Container();
}

Widget _buildTimelineContent(String a, b, c) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Column(
        children: [
          _timecode(a),
          const Padding(padding: EdgeInsets.only(bottom: 5)),
          _timecode(b)
        ],
      ),
      const VerticalDivider(
        color: Colors.grey,
      ),
      Text(c, style: const TextStyle(color: Colors.black54)),
    ],
  );
}

Widget _timecode(String time) {
  return Text(
      time,
      style: const TextStyle(
        color: Colors.black54,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      )
  );
}

enum _TimelineStatus {
  inProgress,
  todo,
}

extension on _TimelineStatus {
  bool get isInProgress => this == _TimelineStatus.inProgress;
}

List<Widget> buildTimelineTabs(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;

  return <Widget>[
    Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TabBar(
          physics: const BouncingScrollPhysics(),
          labelColor: Colors.black54,
          unselectedLabelColor: Colors.grey[400],
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            //borderRadius: BorderRadius.circular(5),
              color: const Color(0xfff7f7f7),
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          isScrollable: true,
          tabs: [1, 2, 3, 4, 5, 6, 7].map((e) =>
              _buildTab("0$e-01", width * 0.05)
          ).toList()
      ),
    ),
    Expanded(
      flex: 1,
      child: TabBarView(children: [
        timeline(),
        timeline(),
        timeline(),
        timeline(),
        timeline(),
        timeline(),
        timeline(),
      ]),
    ),
  ];
}

Widget _buildTab(String label, double size) {
  return Tab(
    child: SizedBox(
      width: 100,
      child: Align(
        alignment: Alignment.center,
        child: Text(label),
      ),
    ),
  );
}