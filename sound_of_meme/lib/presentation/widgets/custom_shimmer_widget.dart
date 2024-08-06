import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import '../../../core/extensions/extensions.dart';

class CustomShimmerWidget extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final bool? isDark;

  const CustomShimmerWidget({
    super.key,
    required this.height,
    required this.width,
    required this.radius,
    this.isDark,
  });

  @override
  Widget build(final BuildContext context) {
    return Builder(
      builder: (context) {
        return FadeShimmer(
          height: height,
          width: width,
          radius: radius,
          fadeTheme: context.isDark ? FadeTheme.dark : FadeTheme.light,
        );
      }
    );
  }
}
