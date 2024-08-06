import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sound_of_meme/core/app_fonts.dart';
import '../../core/constants/constants.dart';
import '../../../core/locator.dart';
import '../../core/utilities/utilities.dart';
import 'app_bloc/app_bloc.dart';
export 'app_bloc/app_bloc.dart';

class App extends StatefulWidget {
  final String initialRoute;
  final AdaptiveThemeMode? savedThemeMode;

  const App({super.key, required this.initialRoute, this.savedThemeMode});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    _listenToThemeChanges();
    super.initState();
  }

  void _listenToThemeChanges() {
    WidgetsBinding.instance.addPostFrameCallback(
      (final Duration timeStamp) async {
        View.of(context).platformDispatcher.onPlatformBrightnessChanged = () {
          if (locator<RouterUtility>().getContext != null) {
            final bool isDarkMode =
                WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                    Brightness.dark;

            if (isDarkMode) {
              AdaptiveTheme.of(locator<RouterUtility>().getContext!).setDark();
            } else {
              AdaptiveTheme.of(locator<RouterUtility>().getContext!).setLight();
            }
          }
        };
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<AppBloc>(),
      child: AdaptiveTheme(
        light: locator<ThemeUtility>().getLightTheme(),
        dark: locator<ThemeUtility>().getDarkTheme(),
        initial: widget.savedThemeMode ?? AdaptiveThemeMode.system,
        builder: (theme, darkTheme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: locator<RouterUtility>().getRoutes,
            navigatorKey: locator<RouterUtility>().navigatorKey,
            initialRoute: widget.initialRoute,
            localizationsDelegates: [
              LocalizationsUtilityDelegate(),
            ],
          );
        },
      ),
    );
  }
}
