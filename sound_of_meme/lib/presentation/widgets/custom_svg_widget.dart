import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvgWidget extends StatelessWidget {
  final String path;
  final double? height, width;
  final Color? color;
  final BoxFit? fit;

  const CustomSvgWidget({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.color,
    this.fit,
  });

  @override
  Widget build(final BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      colorFilter: color != null
          ? ColorFilter.mode(
              color!,
              BlendMode.srcIn,
            )
          : null,
      placeholderBuilder: (final BuildContext context) =>
          const CircularProgressIndicator(),
    );
  }
}
