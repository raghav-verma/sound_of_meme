import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/constants/constants.dart';
import '../../../core/helpers/helpers.dart';
import '../../../domain/validators.dart';
import '../../../generated/assets.dart';
import '../../app/app.dart';
import '../../widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Validators {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late ValueNotifier<ButtonStateEnum> _buttonStateNotifier;
  late ValueNotifier<ButtonStateEnum> _googleButtonStateNotifier;

  @override
  void initState() {
    if (kDebugMode) {
      _emailController.text = 'bibi@gmail.com';
      _passwordController.text = 'apple';
    }
    _buttonStateNotifier = ValueNotifier<ButtonStateEnum>(ButtonStateEnum.idle);
    _googleButtonStateNotifier =
        ValueNotifier<ButtonStateEnum>(ButtonStateEnum.idle);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _buttonStateNotifier.dispose();
    _googleButtonStateNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          _buttonStateNotifier.value = ButtonStateEnum.loading;
        } else if (state is LoginErrorState) {
          _buttonStateNotifier.value = ButtonStateEnum.error;
          context.showWarning(state.message);
        } else if (state is LoginSuccessfulState) {
          if (mounted) {
            context.intentWithoutBack(RouteConstants.homeScreen);
          }
          _buttonStateNotifier.value = ButtonStateEnum.idle;
        } else if (state is GoogleLoginLoadingState) {
          _googleButtonStateNotifier.value = ButtonStateEnum.loading;
        } else if (state is GoogleLoginErrorState) {
          _googleButtonStateNotifier.value = ButtonStateEnum.error;
          context.showWarning(state.message);
        } else if (state is GoogleLoginSuccessfulState) {
          if (mounted) {
            context.intentWithoutBack(RouteConstants.homeScreen);
          }
          _googleButtonStateNotifier.value = ButtonStateEnum.idle;
        }
      },
      child: CustomScaffoldWidget(
        body: SingleChildScrollView(
          child: SizedBox(
            height: context.screenHeight,
            child: Stack(
              children: [
                const Positioned.fill(
                  child: FrostedGlassBackgroundWidget(),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Assets.gifsWhitePepe,
                            fit: BoxFit.fill,
                            height: context.screenHeight / 3.6,
                          ).paddingOnly(left: 38),
                          const CustomSpacerWidget(height: 16),
                          const CustomTextWidget(
                            'Welcome back!',
                            fontSize: 34,
                            fontWeight: AppFontsWeightEnum.bold,
                          ),
                        ],
                      ),
                      const CustomSpacerWidget(height: 30),
                      Column(
                        children: [
                          CustomTextFieldWidget(
                            controller: _emailController,
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            validator: emailValidator,
                            prefixWidget: Icon(
                              Icons.email_outlined,
                              color: context.theme.iconTheme.color,
                              size: 24.0,
                            ),
                          ),
                          const CustomSpacerWidget(height: 16),
                          CustomTextFieldWidget(
                            controller: _passwordController,
                            hintText: 'Password',
                            obscureText: true,
                            validator: passwordValidator,
                            prefixWidget: Icon(
                              Icons.lock_outline,
                              color: context.theme.iconTheme.color,
                              size: 24.0,
                            ),
                          ),
                          const CustomSpacerWidget(height: 28),
                          CustomButtonWidget(
                            stateNotifier: _buttonStateNotifier,
                            onTap: _login,
                            title: 'Login Now',
                          ),
                          const CustomSpacerWidget(height: 16),
                          const CustomTextWidget("or sign in via"),
                          const CustomSpacerWidget(height: 16),
                          CustomButtonWidget(
                            stateNotifier: _googleButtonStateNotifier,
                            onTap: _googleLogin,
                            prefix: SvgPicture.asset(
                              Assets.imagesGoogleSignIn,
                              height: 30,
                            ).paddingOnly(top: 8),
                          ),
                          const CustomSpacerWidget(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTextWidget(
                                "Don't have an account? ",
                                style: context.theme.textTheme.bodyMedium,
                              ),
                              InkWell(
                                onTap: () {
                                  context.intent(RouteConstants.signUpScreen);
                                },
                                child: const CustomTextWidget(
                                  "Sign Up ",
                                  fontWeight: AppFontsWeightEnum.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ).paddingSymmetric(
                  horizontal: 24,
                  vertical: 48,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AppBloc>().add(
            LogInEvent(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          );
    }
  }

  Future<void> _googleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null &&
          user.displayName != null &&
          user.email != null &&
          user.photoURL != null) {
        if (mounted) {
          context.read<AppBloc>().add(
                GoogleLoginEvent(
                  name: user.displayName!,
                  email: user.email!,
                  picture: user.photoURL!,
                ),
              );
        }
      }
    } catch (e) {
      if (mounted) {
        context.showWarning("Error signing in with Google: $e");
      }
      log("Error signing in with Google: $e");
    }
  }
}
