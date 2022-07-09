import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' as foundation;

const bool isProd = foundation.kReleaseMode;

class PlatformHelper {
  static const platform = MethodChannel('flutter.native/helper');

  static Future<bool> isInstalledFromMarket() async {
    bool status = false;
    // development mode is not installed from market
    if (!isProd) {
      return true;
    }
    // apple always install from market
    if (Platform.isIOS) {
      return true;
    }
    // check android
    try {
      status = await platform.invokeMethod('installedFromMarket');
    } on PlatformException catch (e) {
      if (!isProd) {
        foundation.debugPrint(e.toString());
      }
      return false;
    }
    return status;
  }

  static const List<String> packages = [
    'com.guoshi.httpcanary',
  ];

  static Future<bool> isInstalledOneOfPackages(List<String> advancedPackages) async {
    bool status = false;
    // check android
    try {
      final merged = List.from(packages)..addAll(advancedPackages);
      status = await platform.invokeMethod('isInstalledOneOfPackages', {
        'packages': merged,
      });
    } on PlatformException catch (e) {
      if (!isProd) {
        foundation.debugPrint(e.toString());
      }
      return false;
    }
    return status;
  }

  static bool get isDev => foundation.kDebugMode;
}