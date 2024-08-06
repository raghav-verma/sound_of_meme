import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import '../../../core/extensions/extensions.dart';

class CustomRoundShimmerWidget extends StatelessWidget {
  final double size;

  const CustomRoundShimmerWidget({
    super.key,
    required this.size,
  });

  @override
  Widget build(final BuildContext context) {
    return FadeShimmer.round(
      size: size,
      fadeTheme: context.isDark ? FadeTheme.dark : FadeTheme.light,
    );
  }
}
