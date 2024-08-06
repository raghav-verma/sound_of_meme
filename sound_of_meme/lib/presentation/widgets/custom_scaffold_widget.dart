import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/extensions/extensions.dart';
import 'widgets.dart';

class CustomScaffoldWidget extends StatefulWidget {
  final bool useSafeArea;
  final Widget? drawer;
  final Widget? bottomSheet;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool resizeToAvoidBottomInset;
  final Color? backgroundColor;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool extendBody;

  /// Page View Properties:
  final bool showLeading;
  final void Function()? leadingCallback;
  final bool overrideOnWillPopForAppExit;
  final String? overrideOnWillPopMessage;
  final String? title;
  final List<Widget>? options;
  final Widget body;
  final Widget? floatingButton;
  final Widget? leading;
  final Color? statusBarColor;
  final AppBar? appBar;
  final Color? bodyColor;

  const CustomScaffoldWidget({
    this.useSafeArea = true,
    this.drawer,
    this.bottomSheet,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset = true,
    this.backgroundColor,
    this.floatingActionButtonLocation =
        FloatingActionButtonLocation.centerFloat,
    this.extendBody = false,
    this.showLeading = false,
    this.leadingCallback,
    this.title,
    this.options,
    required this.body,
    this.floatingButton,
    this.leading,
    this.statusBarColor,
    this.overrideOnWillPopForAppExit = false,
    this.overrideOnWillPopMessage,
    this.appBar,
    this.bodyColor,
    super.key,
  });

  @override
  State<CustomScaffoldWidget> createState() => _CustomScaffoldWidgetState();
}

class _CustomScaffoldWidgetState extends State<CustomScaffoldWidget> {
  @override
  Widget build(final BuildContext context) {
    final bool isDarkMode = context.isDark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:
          isDarkMode ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      child: GestureDetector(
        onTap: context.hideKeyboard,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color:
                  widget.backgroundColor ?? context.theme.colorScheme.primary,
              alignment: Alignment.topRight,
              child: const CustomSpacerWidget(),
            ),
            if (widget.statusBarColor != null)
              Container(
                height: context.screenHeight / 4,
                color: widget.statusBarColor,
              ),
            SafeArea(
              top: widget.useSafeArea,
              child: Scaffold(
                backgroundColor: widget.backgroundColor ??
                    context.theme.scaffoldBackgroundColor,
                body: BasePageViewWidget(
                  showLeading: widget.showLeading,
                  leadingCallback: widget.leadingCallback,
                  title: widget.title,
                  options: widget.options,
                  body: widget.body,
                  floatingButton: widget.floatingButton,
                  leading: widget.leading,
                  appBar: widget.appBar,
                  bodyColor: widget.bodyColor ?? context.theme.colorScheme.primary,
                ),
                drawer: widget.drawer,
                bottomSheet: widget.bottomSheet,
                bottomNavigationBar: widget.bottomNavigationBar,
                floatingActionButton: widget.floatingActionButton,
                floatingActionButtonLocation:
                    widget.floatingActionButtonLocation,
                resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
                extendBody: widget.extendBody,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
