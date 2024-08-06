import 'dart:developer';

extension GenericExtensions on Object? {

  dynamic get showLog {
    final pattern = RegExp('.{1,100}');
    pattern.allMatches(toString()).forEach(
          (final match) => log(match.group(0) ?? ''),
    );

    return this;
  }

  dynamic showLogAs(final String name) {
    final pattern = RegExp('.{1,100}');
    pattern.allMatches(toString()).forEach(
          (final match) => log(
        match.group(0) ?? '',
        name: name,
      ),
    );

    return this;
  }
}
