import 'package:flutter/material.dart';
import '../../core/extensions/extensions.dart';

class CustomResponsiveWidget extends StatelessWidget {
  final Widget mobileView;
  final Widget? mobileLandScapeView;
  final Widget? tabletView;
  final Widget? tabletLandScapeView;
  final Widget? desktopView;
  final Widget? desktopLandScapeView;

  const CustomResponsiveWidget({
    super.key,
    required this.mobileView,
    this.mobileLandScapeView,
    this.tabletView,
    this.tabletLandScapeView,
    this.desktopView,
    this.desktopLandScapeView,
  });

  @override
  Widget build(final BuildContext context) {
    final bool isTablet = context.screenWidth < 1000 &&
        context.screenWidth >= 600;
    final bool isDesktop = context.screenWidth >= 1000;

    return LayoutBuilder(
      builder: (
        final context,
        final constraints,
      ) {
        Widget view = mobileView;

        if (context.isLandScape) {
          if (isDesktop) {
            if (desktopLandScapeView != null) {
              view = desktopLandScapeView!;
            } else if (desktopView != null) {
              view = desktopView!;
            } else if (tabletLandScapeView != null) {
              view = tabletLandScapeView!;
            } else if (tabletView != null) {
              view = tabletView!;
            }
          } else if (isTablet) {
            if (tabletLandScapeView != null) {
              view = tabletLandScapeView!;
            } else if (tabletView != null) {
              view = tabletView!;
            }
          } else {
            if (mobileLandScapeView != null) {
              view = mobileLandScapeView!;
            }
          }
        } else {
          if (isDesktop && desktopView != null) {
            view = desktopView!;
          } else if (isTablet && tabletView != null) {
            return tabletView!;
          }
        }

        return view;
      },
    );
  }
}
