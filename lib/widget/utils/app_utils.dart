import 'dart:core';
import 'dart:io';
import 'dart:math';


import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:package_info/package_info.dart';

const chars = "abcdefghijklmnopqrstuvwxyz0123456789";

class AppUtils {
  static Future<List<String>> getDeviceDetails() async {
    var deviceName = '';
    var deviceVersion = '';
    var identifier = '';
    final deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException catch (e) {
      Fimber.e('Failed to get platform version: $e');
    }

    return [deviceName, deviceVersion, identifier];
  }

  static Future<String> getAppVersionCode() async {
    var appVersion;
    try {
      var packageInfo = await PackageInfo.fromPlatform();
      appVersion = packageInfo.buildNumber;
    } on PlatformException catch (e) {
      Fimber.e('$e');
    }

    return appVersion;
  }

  static Future<String> getAppVersion() async {
    var appVersion;
    try {
      var packageInfo = await PackageInfo.fromPlatform();
      appVersion = packageInfo.version;
    } on PlatformException catch (e) {
      Fimber.e('$e');
    }

    return appVersion;
  }

  static Future<VersionInfo> getVersions() async {
    var sdkVersion;
    var appVersion;
    final deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        sdkVersion = androidSdkMapping(build.version.sdkInt);
      } else {
        var data = await deviceInfoPlugin.iosInfo;
        sdkVersion = data.utsname.release;
      }

      var packageInfo = await PackageInfo.fromPlatform();
      appVersion = packageInfo.version;
    } on PlatformException catch (e) {
      Fimber.e('Failed to get platform version: $e');
      sdkVersion = Platform.isAndroid ? '6.0.0' : '9.0.0';
    }

    return VersionInfo(sdkVersion, appVersion);
  }

  static String androidSdkMapping(int version) {
    var versionName;
    switch (version) {
      case 28:
        versionName = '9.0.0';
        break;
      case 27:
        versionName = '8.1.0';
        break;
      case 26:
        versionName = '8.0.0';
        break;
      case 25:
        versionName = '7.1.0';
        break;
      case 24:
        versionName = '7.0.0';
        break;
      default:
        versionName = '6.0.0';
        break;
    }
    return versionName;
  }

  static bool compareVersion(String appVer, String minVer) {
    if (appVer.isEmpty || minVer.isEmpty || appVer == minVer) return true;
    var newVerArray = appVer.split('.');
    var orgVerArray = minVer.split('.');

    int minVerLength;
    if (newVerArray.length > orgVerArray.length) {
      minVerLength = orgVerArray.length;
    } else {
      minVerLength = newVerArray.length;
    }

    Fimber.i('minVerLength =$minVerLength');

    for (var i = 0; i <= minVerLength; i++) {
      if (int.parse(newVerArray[i]) > int.parse(orgVerArray[i])) {
        return true;
      } else if (int.parse(newVerArray[i]) < int.parse(orgVerArray[i])) {
        return false;
      }
    }
    return newVerArray.length > orgVerArray.length;
  }

  // static void browserChooser(String url) async {
  //   if (Platform.isAndroid) {
  //     AndroidIntent intent = AndroidIntent(
  //       action: 'action_view',
  //       data: url,
  //     );
  //     await intent.launch();
  //   }
  // }
  //
  // static void shareChooser(String content) async {
  //   if (Platform.isAndroid) {
  //     AndroidIntent intent = AndroidIntent(
  //       action: 'action_send',
  //       arguments: {'extra_text': content},
  //     );
  //     await intent.launch();
  //   }
  // }

  // static String randomString(int strlen) {
  //   Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
  //   String result = "";
  //   for (var i = 0; i < strlen; i++) {
  //     result += chars[rnd.nextInt(chars.length)];
  //   }
  //   return result;
  // }
  //
  // static void showToast(String content) {
  //   Fluttertoast.showToast(
  //       msg: content,
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 3,
  //       backgroundColor: Colors.white,
  //       textColor: Colors.black,
  //       fontSize: 15.0);
  // }
}

class VersionInfo {
  String sdkVersion;
  String appVersion;

  VersionInfo(this.sdkVersion, this.appVersion);
}
