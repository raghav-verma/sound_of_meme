import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget visibility(final bool visibility) {
    return Visibility(
      visible: visibility,
      child: this,
    );
  }

  Widget get addContainerRedDebug {
    if (!kDebugMode) {
      return const SizedBox();
    }
    return Container(
      color: Colors.red,
      child: this,
    );
  }

  Widget get addContainerYellowDebug {
    if (!kDebugMode) {
      return const SizedBox();
    }
    return Container(
      color: Colors.yellow,
      child: this,
    );
  }

  Widget get addContainerGreenDebug {
    if (!kDebugMode) {
      return const SizedBox();
    }
    return Container(
      color: Colors.green,
      child: this,
    );
  }

  Widget paddingAll(final double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  Widget paddingSymmetric({
    final double? horizontal,
    final double? vertical,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal ?? 0,
        vertical: vertical ?? 0,
      ),
      child: this,
    );
  }

  Widget paddingOnly({
    final double top = 0,
    final double bottom = 0,
    final double left = 0,
    final double right = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
      ),
      child: this,
    );
  }

  Widget padding(final EdgeInsets edgeInsets) {
    return Padding(
      padding: edgeInsets,
      child: this,
    );
  }

  Widget get expanded {
    return Expanded(child: this);
  }
}
