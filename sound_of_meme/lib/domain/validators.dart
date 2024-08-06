import 'package:flutter/cupertino.dart';

mixin Validators {
  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }

    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  String? confirmPasswordValidator(
      String? value, final TextEditingController passwordController) {
    if (value == null || value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
