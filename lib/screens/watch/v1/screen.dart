// native
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// dependencies
import 'package:better_player/better_player.dart';
import 'package:wakelock/wakelock.dart';

// application
import 'package:bormental/types/channel.dart';
import 'timeline.dart';

class WatchScreen extends StatefulWidget {
  final Channel channel;

  const WatchScreen({
    Key? key,
    required this.channel
  }) : super(key: key);

  @override
  _WatchScreenState createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  final GlobalKey _betterPlayerKey = GlobalKey();

  var betterPlayerConfiguration = const BetterPlayerConfiguration(
    fit: BoxFit.contain,
    autoDetectFullscreenDeviceOrientation: true,
    autoPlay: true,
    looping: true,
    fullScreenByDefault: false,
    allowedScreenSleep: false,
    controlsConfiguration:
    BetterPlayerControlsConfiguration(
      playerTheme: BetterPlayerTheme.cupertino,
    ),
  );

  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();

    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      'https://demopage.gcdn.co/cmaf/2675_19146/index.mpd',
      liveStream: true,
    );

    _betterPlayerController = BetterPlayerController(
        betterPlayerConfiguration,
        betterPlayerDataSource: dataSource
    );

    Wakelock.enable();
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    Wakelock.disable();

    super.dispose();
  }

  Widget _buildPanel(BuildContext context) {
    return Row(
      children: <Widget>[
        buildNetworkImage(widget.channel.channelLogo, size: 30),
        const Spacer(),
        IconButton(
          onPressed: () {
            _betterPlayerController.enablePictureInPicture(_betterPlayerKey);
          },
          icon: const Icon(
            Icons.picture_in_picture,
            color: Colors.black54,
          ),
        ),
        IconButton(
          onPressed: () {

          },
          icon: const Icon(
            Icons.comment,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: DefaultTabController(
          length: 7,
          child: Scaffold(
            body: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                  top: statusBarHeight,
                ),
                child: OrientationBuilder(
                  builder: (BuildContext context, Orientation orientation) {
                    if (orientation == Orientation.landscape) {
                      return Row(
                        children: <Widget>[
                          Flexible(
                            flex: 5,
                            child: Column(
                              children: <Widget>[
                                ...buildTimelineTabs(context),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                children: <Widget>[
                                  _buildPanel(context),
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child: AspectRatio(
                                      aspectRatio: 4 / 3,
                                      child: BetterPlayer(
                                        controller: _betterPlayerController,
                                        key: _betterPlayerKey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }

                    return Column(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: BetterPlayer(
                            controller: _betterPlayerController,
                            key: _betterPlayerKey,
                          ),
                        ),
                        _buildPanel(context),
                        ...buildTimelineTabs(context),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        )
    );
  }
}

Widget buildNetworkImage(String image, {double size: 65}) {
  return Container(
    alignment: Alignment.center,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 0,
      child: Padding(
          padding: const EdgeInsets.all(5),
          child: Image.network(image, height: size, width: size)
      ),
    ),
  );
}