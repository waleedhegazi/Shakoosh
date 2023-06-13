import 'package:flutter/material.dart';
import 'package:test_app/Login_Password_TextField.dart';
import 'package:test_app/data_models/User_Account_Model.dart';
import 'package:test_app/register/Register_Next_Button.dart';
import 'package:test_app/repository/Authentication_Repository.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:test_app/Shakoosh_icons.dart';

class Login extends StatefulWidget {
  final void Function() onBackButtonTap;
  final void Function() whenRegister;
  const Login(
      {required this.whenRegister, required this.onBackButtonTap, super.key});
  @override
  State<Login> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordIsVisible = false;
  bool showError = false;
  double screenHeight = 0;
  double screenWidth = 0;
  bool isAuthenticating = false;

  String? _getEmailError() {
    final text = _emailController.value.text.trim();
    if (text.isEmpty) {
      return "Can not be empty!";
    } else if (!Accounts.isEmail(text)) {
      return "Please use a valid E-mail";
    } else {
      return null;
    }
  }

  String? _getPasswordError() {
    final text = _passwordController.value.text.trim();
    if (text.isEmpty) {
      return "Can not be empty!";
    } else {
      return null;
    }
  }

  void _changeVisibility() {
    setState(() {
      _passwordIsVisible = !_passwordIsVisible;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _loginTap() async {
    setState(() {
      if (!(_getEmailError() == null && _getPasswordError() == null)) {
        showError = true;
      } else {
        setState(() {
          isAuthenticating = true;
        });
        _signIn(_emailController.text.trim(), _passwordController.text.trim());
      }
    });
  }

  void _signIn(String email, String password) async {
    String? error = await AuthenticationRepository.signIn(email, password);
    if (error == null) {
      _showMessage("Signed in");
    } else {
      _showErrorMessage(error);
      setState(() {
        isAuthenticating = false;
      });
    }
  }

  void _showMessage(String txt) {
    showTopSnackBar(
        Overlay.of(context),
        Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(155, 42, 124, 45),
                borderRadius: BorderRadius.circular(20)),
            child: SizedBox(
              height: 50,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(ShakooshIcons.logo_transparent_black_2,
                    size: 40, color: Colors.white),
                Container(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(txt,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white)))
              ]),
            )));
  }

  void _showErrorMessage(String txt) {
    showTopSnackBar(
        Overlay.of(context),
        Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(155, 156, 21, 11),
              borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            height: 50,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(ShakooshIcons.logo_transparent_black_2,
                  size: 40, color: Colors.white),
              Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(txt,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white)))
            ]),
          ),
        ));
  }

  void _onRegisterTap() {
    widget.whenRegister();
  }

  void _forgotPassword() {}

  @override
  Widget build(context) {
    screenHeight = (MediaQuery.of(context).size.height);
    //- (MediaQuery.of(context).padding.top) -
    // (MediaQuery.of(context).padding.bottom);
    screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
        child: AnimatedBuilder(
      animation: Listenable.merge([_emailController, _passwordController]),
      builder: (context, __) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  width: 3)),
                          errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 167, 34, 24),
                                  width: 1)),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 167, 34, 24),
                                  width: 3)),
                          errorStyle: const TextStyle(
                              color: Color.fromARGB(255, 167, 34, 24)),
                          labelText: 'E-mail',
                          labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold),
                          errorText: showError ? _getEmailError() : null,
                          hintText: 'Enter your Email',
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Theme.of(context).colorScheme.secondary,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  PasswordField(
                      isVisible: _passwordIsVisible,
                      error: _getPasswordError(),
                      controller: _passwordController,
                      iconOnTap: _changeVisibility,
                      label: "Password",
                      hint: "Enter your password",
                      showError: showError,
                      passwordStrengthScore: 0),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  !isAuthenticating
                      ? TextButton(
                          onPressed: _loginTap,
                          child: Text("Sign in",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold)))
                      : CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.secondary),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  TextButton(
                      child: Text("Forgot your password?",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          )),
                      onPressed: _forgotPassword),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? ",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary)),
                      TextButton(
                          onPressed: _onRegisterTap,
                          child: Text(
                            "Register",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ]),
          ),
        );
      },
    ));
  }
}
