import 'package:flutter/material.dart';

class CustomSpacerWidget extends StatelessWidget {
  final double? height, width;

  const CustomSpacerWidget({
    super.key,
    this.height,
    this.width,
  });

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}
