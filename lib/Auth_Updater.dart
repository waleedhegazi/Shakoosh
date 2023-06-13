import 'package:flutter/material.dart';
import 'package:test_app/Auth_Main_Screen.dart';
import 'package:test_app/Login_Screen.dart';
import 'package:test_app/register/Register_Screen.dart';

class AuthUpdater extends StatefulWidget {
  const AuthUpdater({super.key});
  @override
  State<AuthUpdater> createState() {
    return _AuthUpdaterState();
  }
}

class _AuthUpdaterState extends State<AuthUpdater> {
  Widget? activeScreen;
  double screenHeight = 0;
  double screenWidth = 0;
  @override
  void initState() {
    
    activeScreen = LoginAndRegister(
        whenLogin: _whenLogin,
        whenRegister: _whenRegister,
        onBackButtonTap: _onBackButtonTap);
    super.initState();
  }

  void _onBackButtonTap() {
    setState(() {
      activeScreen = LoginAndRegister(
          whenLogin: _whenLogin,
          whenRegister: _whenRegister,
          onBackButtonTap: _onBackButtonTap);
    });
  }

  void _whenLogin() {
    setState(() {
      activeScreen =
          Login(whenRegister: _whenRegister, onBackButtonTap: _onBackButtonTap);
    });
  }

  void _whenRegister() {
    setState(() {
      activeScreen =
          Register(whenLogin: _whenLogin, onBackButtonTap: _onBackButtonTap);
    });
  }

  @override
  Widget build(context) {
    screenHeight = (MediaQuery.of(context).size.height);
    //- (MediaQuery.of(context).padding.top) -
    // (MediaQuery.of(context).padding.bottom);
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
          color: const Color.fromARGB(255, 245, 196, 63),
          height: screenHeight,
          width: screenWidth,
          child: activeScreen),
    );
  }
}
