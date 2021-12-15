class Channel {
  final Current current;
  final String name;
  final String logo;

  Channel(this.current, this.name, this.logo);

  String get channelName => name;
  String get channelLogo {
    if (logo.isEmpty) {
      return defaultImage;
    }

    return logo;
  }
}

class Current {
  final int begin;
  final int end;
  final String current;

  Current(this.begin, this.end, this.current);

  String get currentProgram => current;
  int get currentProgramStart => begin;
  int get currentProgramStop => end;
}

const defaultImage = 'https://raw.githubusercontent.com/zikwall/moye/master/you_my_our.png';