import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/constants.dart';

class LocalizationsUtility {
  LocalizationsUtility._privateConstructor();

  static final LocalizationsUtility _instance =
  LocalizationsUtility._privateConstructor();

  static LocalizationsUtility get instance => _instance;

  static Map<String, dynamic>? _language;

  final _reloadController = StreamController<void>.broadcast();

  Stream<void> get onLocaleChanged => _reloadController.stream;

  static LocalizationsUtility of(final BuildContext context) {
    return Localizations.of<LocalizationsUtility>(
      context,
      LocalizationsUtility,
    )!;
  }

  String getString(final String key) =>
      (_language != null && _language!.containsKey(key) ? _language![key] : key).toString();

  void reloadLocalizations() {
    _reloadController.sink.add(null);
  }

  void dispose() {
    _reloadController.close();
  }

  static Future<void> loadLanguage(final Locale locale) async {
    const String path = AssetConstants.enJsonPath;
    final String string = await rootBundle.loadString('$path${locale.languageCode}.json');
    _language = json.decode(string) as Map<String, dynamic>?;
  }
}

class LocalizationsUtilityDelegate
    extends LocalizationsDelegate<LocalizationsUtility> {
  @override
  bool isSupported(final Locale locale) => ['en'].contains(locale.languageCode);

  @override
  Future<LocalizationsUtility> load(final Locale locale) async {
    await LocalizationsUtility.loadLanguage(locale);
    return SynchronousFuture<LocalizationsUtility>(
      LocalizationsUtility.instance,
    );
  }

  @override
  bool shouldReload(final LocalizationsUtilityDelegate old) => true;
}
