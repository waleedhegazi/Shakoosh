import 'package:flutter/material.dart';
import 'package:test_app/Login_Password_TextField.dart';
import 'package:test_app/register/Register_Next_Button.dart';

class RegisterPasswordTextFields extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmedPasswordController;
  final bool passwordIsVisible;
  final bool confirmedPasswordIsVisible;
  final String? passwordError;
  final String? confirmedPasswordError;
  final String passwordHelper;
  final String? confirmedPasswordHelper;
  final void Function() passwordOnTap;
  final void Function() confirmedPasswordOnTap;
  final bool showError;
  final int passwordStrengthScore;
  final void Function() onButtonTap;
  final String buttonTitle;

  const RegisterPasswordTextFields(
      {required this.passwordController,
      required this.passwordIsVisible,
      required this.passwordError,
      required this.passwordHelper,
      required this.passwordOnTap,
      required this.confirmedPasswordController,
      required this.confirmedPasswordIsVisible,
      required this.confirmedPasswordError,
      required this.confirmedPasswordOnTap,
      required this.confirmedPasswordHelper,
      required this.showError,
      required this.passwordStrengthScore,
      required this.onButtonTap,
      required this.buttonTitle,
      super.key});

  @override
  Widget build(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PasswordField(
          controller: passwordController,
          isVisible: passwordIsVisible,
          iconOnTap: passwordOnTap,
          error: passwordError,
          helper: passwordHelper,
          label: "Password",
          hint: "Enter a new password",
          showError: showError,
          passwordStrengthScore: passwordStrengthScore,
        ),
        const SizedBox(
          height: 50,
        ),
        PasswordField(
          controller: confirmedPasswordController,
          isVisible: confirmedPasswordIsVisible,
          iconOnTap: confirmedPasswordOnTap,
          error: confirmedPasswordError,
          helper: confirmedPasswordHelper,
          label: "Confirm password",
          hint: "Re-enter your password",
          showError: showError,
          passwordStrengthScore: 0,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        NextButton(onTap: onButtonTap, title: buttonTitle)
      ],
    );
  }
}
