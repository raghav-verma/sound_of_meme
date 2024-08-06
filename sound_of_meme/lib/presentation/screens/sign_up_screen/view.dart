import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with Validators {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _emailController;
  late TextEditingController _nameController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  late ValueNotifier<ButtonStateEnum> _buttonStateNotifier;
  late ValueNotifier<ButtonStateEnum> _googleButtonStateNotifier;

  @override
  void initState() {
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _buttonStateNotifier = ValueNotifier<ButtonStateEnum>(ButtonStateEnum.idle);
    _googleButtonStateNotifier =
        ValueNotifier<ButtonStateEnum>(ButtonStateEnum.idle);

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state is SignUpLoadingState) {
          _buttonStateNotifier.value = ButtonStateEnum.loading;
        } else if (state is SignUpErrorState) {
          _buttonStateNotifier.value = ButtonStateEnum.error;
          context.showWarning(state.message);
        } else if (state is SignUpSuccessfulState) {
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
                  child: SafeArea(
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Assets.imagesPepeLogo12,
                              height: context.screenHeight / 8,
                            ),
                            const CustomTextWidget(
                              "Create Account",
                              fontSize: 34,
                              fontWeight: AppFontsWeightEnum.semiBold,
                            ),
                          ],
                        ),
                        const CustomSpacerWidget(height: 30),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            CustomTextFieldWidget(
                              controller: _nameController,
                              hintText: 'Name',
                              validator: nameValidator,
                              prefixWidget: Icon(
                                Icons.account_circle_outlined,
                                color: context.theme.iconTheme.color,
                                size: 24.0,
                              ),
                            ),
                            const CustomSpacerWidget(height: 16),
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
                            const CustomSpacerWidget(height: 16),
                            CustomTextFieldWidget(
                              controller: _confirmPasswordController,
                              hintText: 'Confirm Password',
                              obscureText: true,
                              validator: (value) => confirmPasswordValidator(
                                  value, _passwordController),
                              prefixWidget: Icon(
                                Icons.lock_outline,
                                color: context.theme.iconTheme.color,
                                size: 24.0,
                              ),
                            ),
                            const CustomSpacerWidget(height: 38),
                            CustomButtonWidget(
                              stateNotifier: _buttonStateNotifier,
                              onTap: _signUp,
                              title: 'Sign up',
                            ),
                            const CustomSpacerWidget(height: 16),
                            const CustomTextWidget("or sign up via"),
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
                                  "Already have an account? ",
                                  style: context.theme.textTheme.bodyMedium,
                                ),
                                InkWell(
                                  onTap: () {
                                    context.intent(RouteConstants.loginScreen);
                                  },
                                  child: const CustomTextWidget(
                                    "Login",
                                    fontWeight: AppFontsWeightEnum.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ).paddingSymmetric(
                  horizontal: 16,
                  vertical: 32,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signUp() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AppBloc>().add(
            SignUpEvent(
              name: _nameController.text,
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
        log("Error signing in with Google: $e");
      }
    }
  }
}
