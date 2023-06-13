import 'package:flutter/material.dart';
import 'package:test_app/Shakoosh_Icons.dart';

class LoginAndRegister extends StatelessWidget {
  final void Function() whenRegister;
  final void Function() whenLogin;
  final void Function() onBackButtonTap;

  const LoginAndRegister(
      {required this.onBackButtonTap,
      required this.whenLogin,
      required this.whenRegister,
      super.key});
  @override
  Widget build(context) {
    double screenHeight = (MediaQuery.of(context).size.height);
    -(MediaQuery.of(context).padding.top) -
        (MediaQuery.of(context).padding.bottom);
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: screenHeight * 0.15),
        Icon(ShakooshIcons.logo_transparent_black_2,
            color: Theme.of(context).colorScheme.secondary,
            size: screenWidth * 0.4),
        SizedBox(height: screenHeight * 0.05),
        TextButton(
            onPressed: whenLogin,
            style: TextButton.styleFrom(
                fixedSize: const Size(150, 7),
                shape: const RoundedRectangleBorder(),
                backgroundColor: Theme.of(context).colorScheme.secondary),
            child: const Text(
              'Sign in',
              style: TextStyle(
                  color: const Color.fromARGB(255, 245, 196, 63), fontSize: 14),
            )),
        const SizedBox(height: 7),
        TextButton(
            onPressed: whenRegister,
            style: TextButton.styleFrom(
              fixedSize: const Size(150, 7),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: BorderSide(
                      width: 1.5,
                      color: Theme.of(context).colorScheme.secondary)),
              backgroundColor: const Color.fromARGB(0, 0, 0, 0),
            ),
            child: Text(
              'Register',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary, fontSize: 14),
            )),
      ],
    );
  }
}
