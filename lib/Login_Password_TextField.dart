import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String? error;
  final bool isVisible;
  final void Function() iconOnTap;
  final String? helper;
  final String label;
  final String hint;
  final int passwordStrengthScore;
  final bool showError;
  static Color? counterColor;

  const PasswordField(
      {required this.isVisible,
      required this.error,
      required this.controller,
      required this.iconOnTap,
      required this.label,
      required this.hint,
      required this.showError,
      required this.passwordStrengthScore,
      this.helper,
      super.key});

  String? _getCounterText(int passwordStrngthScore) {
    if (passwordStrengthScore < 7) {
      counterColor = Colors.red[600];
      return 'Weak';
    }
    if (passwordStrengthScore < 9) {
      counterColor = Colors.white;
      return 'Medium';
    }
    counterColor = Colors.green[800];
    return 'Strong';
  }

  @override
  Widget build(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        controller: controller,
        obscureText: !isVisible,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary, width: 3)),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 167, 34, 24), width: 1)),
          focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 167, 34, 24), width: 3)),
          errorStyle: const TextStyle(color: Color.fromARGB(255, 167, 34, 24)),
          labelText: label,
          labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          helperText: helper,
          helperStyle:
              TextStyle(color: Theme.of(context).colorScheme.secondary),
          errorText: showError ? error : null,
          counterText: (passwordStrengthScore == 0)
              ? null
              : _getCounterText(passwordStrengthScore),
          counterStyle: TextStyle(color: counterColor),
          prefixIcon: Icon(
            Icons.lock_person,
            color: Theme.of(context).colorScheme.secondary,
          ),
          suffixIcon: IconButton(
              icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).colorScheme.secondary),
              onPressed: iconOnTap),
        ),
      ),
    );
  }
}
