import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class PlatformUtil {
  OS getPlatform() {
    if (kIsWeb) {
      return OS.web;
    } else if (Platform.isIOS) {
      return OS.ios;
    } else if (Platform.isAndroid) {
      return OS.android;
    } else if (Platform.isFuchsia) {
      return OS.fuchsia;
    } else if (Platform.isLinux) {
      return OS.linux;
    } else if (Platform.isMacOS) {
      return OS.macos;
    } else if (Platform.isWindows) {
      return OS.windows;
    }
    return OS.unknown;
  }

  bool isWeb() {
    return (getPlatform() == OS.web);
  }

  bool isMobile() {
    OS platform = getPlatform();
    return (platform == OS.android ||
        platform == OS.ios ||
        platform == OS.fuchsia);
  }

  bool isComputer() {
    OS platform = getPlatform();
    return (platform == OS.linux ||
        platform == OS.macos ||
        platform == OS.windows);
  }
}

enum OS { unknown, web, android, fuchsia, ios, linux, macos, windows }
