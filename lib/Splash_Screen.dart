import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  final String textMessage;
  const SplashScreen({required this.textMessage, super.key});
  @override
  Widget build(context) {
    return Scaffold(
      body: Container(
          color: const Color.fromARGB(255, 245, 196, 63),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Lottie.asset(
                          'assets/animations/logo_appears_from_down.json'))),
              Text(textMessage,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16))
            ],
          )),
    );
  }
}
