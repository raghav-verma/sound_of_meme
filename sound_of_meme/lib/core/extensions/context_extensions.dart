import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import '../../../core/locator.dart';
import '../utilities/utilities.dart';

extension ContextExtensions on BuildContext {
  double get screenHeight {
    return MediaQuery.of(this).size.height;
  }

  double get screenWidth {
    return MediaQuery.of(this).size.width;
  }

  bool get isPortrait {
    return MediaQuery.of(this).orientation == Orientation.portrait;
  }

  bool get isLandScape {
    return MediaQuery.of(this).orientation == Orientation.landscape;
  }

  bool get isMobile => !isTablet && !isDesktop;

  bool get isTablet =>
      MediaQuery.of(this).size.width < 1000 &&
      MediaQuery.of(this).size.width >= 600;

  bool get isDesktop => MediaQuery.of(this).size.width >= 1000;

  void hideKeyboard() {
    FocusScope.of(this).requestFocus(FocusNode());
  }

  String stringForKey(final String? key) {
    return LocalizationsUtility.of(this).getString(key ?? '');
  }

  void showWarning(final String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  bool get isDark => AdaptiveTheme.of(this).mode.isDark;

  ThemeData get theme => AdaptiveTheme.of(this).theme;

  ///ROUTER START///
  bool get canGoBack {
    return locator<RouterUtility>().canPop(this);
  }

  void back() {
    locator<RouterUtility>().pop(this);
  }

  void backWithData(final Object? object) {
    locator<RouterUtility>().pop(
      this,
      data: object,
    );
  }

  void intent(final String routePathName) {
    locator<RouterUtility>().intent<void>(
      context: this,
      routeName: routePathName,
    );
  }

  void intentWithData(
    final String routePathName,
    final Object object,
  ) {
    locator<RouterUtility>().intent<void>(
      context: this,
      routeName: routePathName,
      data: object,
    );
  }

  void intentWithoutBack(
    final String routePathName,
  ) {
    locator<RouterUtility>().intent<void>(
      context: this,
      routeName: routePathName,
      clearHistory: true,
    );
  }

  Future<T?> intentWithResult<T>(
    final String routePathName,
  ) async {
    return await locator<RouterUtility>().intent<T?>(
      context: this,
      routeName: routePathName,
    );
  }

  Future<T?> intentWithDataAndResult<T>(
    final String routePathName,
    final Object object,
  ) async {
    return await locator<RouterUtility>().intent<T?>(
      context: this,
      routeName: routePathName,
      data: object,
    );
  }

  void intentWithoutBackWithData(
    final String routePathName,
    final Object object,
  ) {
    locator<RouterUtility>().intent<void>(
      context: this,
      routeName: routePathName,
      clearHistory: true,
      data: object,
    );
  }

  ///ROUTER END///
}
