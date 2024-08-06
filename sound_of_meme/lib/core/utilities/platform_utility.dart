import 'package:flutter/foundation.dart';
import 'package:platform/platform.dart';
import 'package:device_info_plus/device_info_plus.dart';

import '../constants/constants.dart';

abstract interface class PlatformUtility {
  bool get isWeb;

  bool get isAndroid;

  bool get isIos;

  String get getPlatformName;

  bool get isDebugMode;
}

class PlatformUtilityImplementation implements PlatformUtility {
  final Platform platform = const LocalPlatform();
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  @override
  final bool isWeb = kIsWeb;

  @override
  bool get isAndroid {
    return !isWeb && platform.isAndroid;
  }

  @override
  bool get isIos {
    return !isWeb && platform.isIOS;
  }

  @override
  String get getPlatformName {
    if (isWeb) {
      return 'Web';
    } else {
      if (platform.isAndroid) {
        return 'Android';
      } else if (platform.isIOS) {
        return 'iOS';
      }
    }

    return 'Unknown';
  }

  @override
  bool get isDebugMode {
    return kDebugMode && !AppConstants.disableDebugMode;
  }
}
