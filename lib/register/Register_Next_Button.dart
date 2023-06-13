import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final void Function() onTap;
  final String title;
  const NextButton({required this.title, required this.onTap, super.key});

  @override
  Widget build(context) {
    return TextButton(
        onPressed: onTap,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ));
  }
}
