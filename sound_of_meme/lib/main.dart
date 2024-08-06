import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'core/constants/constants.dart';
import 'core/locator.dart';
import 'data/data_sources/data_sources.dart';
import 'presentation/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await setupLocator();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(
      App(initialRoute: await getInitialRoute, savedThemeMode: savedThemeMode));
  FlutterNativeSplash.remove();
}

Future<bool> get isLoggedIn async {
  final String? accessToken = await locator<LocalDataSource>().getAccessToken();
  return accessToken != null && accessToken.isNotEmpty;
}

Future<String> get getInitialRoute async {
  return (await isLoggedIn)
      ? RouteConstants.homeScreen
      : RouteConstants.loginScreen;
}
