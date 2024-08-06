import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/screens/screens.dart';
import '../../presentation/widgets/widgets.dart';
import '../constants/constants.dart';
import '../../../core/locator.dart';

abstract class RouterUtility {
  BuildContext? get getContext;

  GlobalKey<NavigatorState> get navigatorKey;

  Future<T?> intent<T>({
    required final BuildContext context,
    required final String routeName,
    final bool clearHistory = false,
    final Object? data,
  });

  void tryIntentWithoutContext({
    required final String routeName,
    final bool clearHistory = false,
    final Object? data,
  });

  bool canPop(final BuildContext context);

  void pop(
    final BuildContext context, {
    final Object? data,
  });

  void tryPopWithoutContext();

  Map<String, WidgetBuilder> get getRoutes;
}

class RouterUtilityImplementation implements RouterUtility {
  GlobalKey<NavigatorState>? _navigatorKey;

  @override
  GlobalKey<NavigatorState> get navigatorKey {
    _navigatorKey ??= GlobalKey<NavigatorState>();
    return _navigatorKey!;
  }

  @override
  BuildContext? get getContext {
    return navigatorKey.currentState?.context;
  }

  @override
  Future<T?> intent<T>({
    required final BuildContext context,
    required final String routeName,
    final bool clearHistory = false,
    final Object? data,
  }) async {
    if (clearHistory) {
      await Navigator.of(context).pushNamedAndRemoveUntil(
        routeName,
        (final route) => false,
        arguments: data,
      );

      return null;
    } else {
      return (await Navigator.of(context).pushNamed(
        routeName,
        arguments: data,
      )) as T;
    }
  }

  @override
  void tryIntentWithoutContext({
    required final String routeName,
    final bool clearHistory = false,
    final Object? data,
  }) {
    if (navigatorKey.currentState == null) {
      log('Intent without context failure for $routeName');
    }

    if (clearHistory) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        routeName,
        (final route) => false,
        arguments: data,
      );
    } else {
      navigatorKey.currentState?.pushNamed(
        routeName,
        arguments: data,
      );
    }
  }

  @override
  void tryPopWithoutContext() {
    navigatorKey.currentState?.pop();
  }

  @override
  bool canPop(final BuildContext context) {
    return Navigator.of(context).canPop();
  }

  @override
  void pop(
    final BuildContext context, {
    final Object? data,
  }) {
    if (canPop(context)) {
      Navigator.pop(
        context,
        data,
      );
    } else {
      SystemNavigator.pop();
    }
  }

  @override
  Map<String, WidgetBuilder> get getRoutes {
    return {
      RouteConstants.loginScreen: (final context) => const LoginScreen(),
      RouteConstants.homeScreen: (final context) => MultiBlocProvider(
            providers: [
              BlocProvider<CurrentSongCubit>(
                create: (BuildContext context) => locator<CurrentSongCubit>(),
              ),
              BlocProvider<HomeBloc>(
                create: (BuildContext context) => locator<HomeBloc>(),
              ),
              BlocProvider<SongBloc>(
                create: (BuildContext context) => locator<SongBloc>(),
              ),
            ],
            child: const HomeScreen(),
          ),

      RouteConstants.signUpScreen: (final context) => const SignUpScreen(),

    };
  }
}
