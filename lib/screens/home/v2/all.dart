// native
import 'package:flutter/material.dart';

// dependencies
import 'package:shimmer/shimmer.dart';

// application
import 'package:bormental/types/channel.dart';
import 'package:bormental/screens/home/v2/channel.dart';

class AllScreen extends StatefulWidget {
  const AllScreen({Key? key}) : super(key: key);
  @override
  _AllScreenState createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> with AutomaticKeepAliveClientMixin<AllScreen> {
  final refreshKey = GlobalKey<RefreshIndicatorState>();
  // states
  late List<Channel> channels;
  bool isLoaded = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    updateChannels();
  }

  void updateChannels() {
    setState(() {
      isLoaded = false;
    });
    Future.delayed(const Duration(milliseconds: 2500), () {
      setState(() {
        channels = getChannels();
        isLoaded = true;
      });
    });
  }

  Future updateState() {
    return Future.delayed(const Duration(milliseconds: 1500), () {
      print("REFRESH ALL");
      updateChannels();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!isLoaded) {
      return const ChannelsShimmer();
    }
    return RefreshIndicator(
      key: refreshKey,
      color: Colors.green,
      onRefresh: () {
        return updateState();
      },
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: channels.map((channel) => InkWell(
          onTap: () {},
          child: ChannelItem(channel: channel),
        )
        ).toList(),
      ),
    );
  }
}

class ChannelsShimmer extends StatelessWidget {
  const ChannelsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 140;
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    color: Colors.white,
                    height: 80.0,
                    width: 80.0,
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: width,
                      height: 12.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.0),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: width,
                      height: 10.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.0),
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: width,
                      height: 1.0,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: width,
                      height: 10.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.0),
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          itemCount: 6,
        )
    );
  }
}