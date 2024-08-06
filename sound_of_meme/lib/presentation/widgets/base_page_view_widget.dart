import 'package:flutter/material.dart';
import 'package:sound_of_meme/core/extensions/extensions.dart';
import 'package:sound_of_meme/core/utilities/platform_utility.dart';
import 'package:sound_of_meme/presentation/widgets/widgets.dart';

import '../../core/helpers/helpers.dart';
import '../../core/locator.dart';
import '../app/app.dart';

class BasePageViewWidget extends StatelessWidget {
  const BasePageViewWidget({
    super.key,
    this.showLeading = true,
    this.leadingCallback,
    this.title,
    this.subTitle,
    this.options,
    required this.body,
    this.floatingButton,
    this.leading,
    this.subTitleWidget,
    this.tabController,
    this.subTitleSuffix,
    this.appBar,
    this.bodyColor,
  });

  final bool showLeading;
  final void Function()? leadingCallback;
  final String? title;
  final String? subTitle;
  final String? subTitleSuffix;
  final List<Widget>? options;
  final Widget body;
  final Widget? floatingButton;
  final Widget? leading;
  final PreferredSizeWidget? subTitleWidget;
  final TabController? tabController;
  final AppBar? appBar;
  final Color? bodyColor;

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: showAppBar
                ? subTitleWidget != null
                    ? 10
                    : subTitle != null
                        ? 9
                        : 8
                : 0,
            child: appBar ??
                AppBar(
                  automaticallyImplyLeading: showLeading,
                  surfaceTintColor: context.theme.primaryColor,
                  elevation: 0,
                  centerTitle: true,
                  title: CustomTextWidget(
                    title,
                    fontSize: 20,
                    fontWeight: AppFontsWeightEnum.bold,
                  ),
                  actions: options,
                  leading: leading ??
                      InkWell(
                        onTap: () {
                          if (leadingCallback != null) {
                            leadingCallback!();
                          } else {
                            context.back();
                          }
                        },
                        child: Icon(
                          locator<PlatformUtility>().isAndroid
                              ? Icons.arrow_back
                              : Icons.arrow_back_ios,
                          color: context.theme.iconTheme.color,
                        ).paddingOnly(top: 8, bottom: 8, left: 18, right: 18),
                      ).visibility(showLeading),
                  backgroundColor: Color(0xFF1A1D2A),
                ).visibility(showAppBar),
          ),
          Expanded(
            flex: (showAppBar && showLeading)
                ? 80
                : (showAppBar && !showLeading)
                    ? 92
                    : 100,
            child: Container(
              color: bodyColor,
              child: body,
            ),
          ),
          SizedBox(
            width: context.isTablet ? context.screenWidth / 1.8 : null,
            child: floatingButton?.paddingSymmetric(
                  vertical: 20,
                ) ??
                const SizedBox(),
          ),
        ],
      ),
    );
  }

  bool get showAppBar => title != null || options != null || showLeading;
}
