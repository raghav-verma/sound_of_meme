import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sound_of_meme/core/extensions/context_extensions.dart';

class FrostedGlassBackgroundWidget extends StatelessWidget {
  const FrostedGlassBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final lightGradient = LinearGradient(
      colors: [
        context.theme.canvasColor.withOpacity(0.6),
        context.theme.canvasColor.withOpacity(0.3),
        context.theme.canvasColor.withOpacity(0.4),
        context.theme.canvasColor.withOpacity(0.6),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final darkGradient = LinearGradient(
      colors: [
        context.theme.primaryColor.withOpacity(0.9),
        context.theme.primaryColor.withOpacity(0.7),
        context.theme.primaryColor.withOpacity(0.9),
        context.theme.primaryColor.withOpacity(0.9),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final gradient = context.isDark ? darkGradient : lightGradient;

    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: context.isDark
              ? context.theme.primaryColor.withOpacity(0.3)
              : context.theme.primaryColor.withOpacity(0.1),
        ),
      ),
    );
  }
}
