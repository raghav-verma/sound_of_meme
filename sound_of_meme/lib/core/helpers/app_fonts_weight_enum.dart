import 'package:flutter/material.dart';

enum AppFontsWeightEnum {
  black(FontWeight.w900),
  extraBold(FontWeight.w800),
  bold(FontWeight.w700),
  semiBold(FontWeight.w600),
  medium(FontWeight.w500),
  regular(FontWeight.w400),
  thin(FontWeight.w300);

  const AppFontsWeightEnum(this.value);

  final FontWeight value;
}
