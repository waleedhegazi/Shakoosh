import 'package:flutter/material.dart';
import 'package:test_app/Login_Email_TextField.dart';
import 'package:test_app/data_models/User_Account_Model.dart';
import 'package:test_app/register/Register_Password_TextFields.dart';
import 'package:test_app/register/Register_Name_TextFields.dart';
import 'package:test_app/register/Register_Mobile_Number_Text_Field.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:test_app/Shakoosh_icons.dart';
import 'package:test_app/repository/User_Repository.dart';
import 'package:test_app/repository/Authentication_Repository.dart';
import 'package:test_app/register/Register_OTP_Screen.dart';
import 'package:intl/intl.dart';
import 'package:test_app/Custom_Page_Route.dart';

class Register extends StatefulWidget {
  final void Function() onBackButtonTap;
  final void Function() whenLogin;
  const Register(
      {required this.whenLogin, required this.onBackButtonTap, super.key});
  @override
  State<Register> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmedPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  bool _passwordIsVisible = false;
  bool _confirmedPasswordIsVisible = false;
  String _backButtonTitle = "Cancel";
  int _screenIndex = 0;
  bool _showError = false;
  int _passwordStrengthScore = 0;
  double screenHeight = 0;
  double screenWidth = 0;
  bool isAuthenticating = false;

  String? _getEmailError() {
    final text = _emailController.text.trim();
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
      return "Can not be empty";
    } else if (text.length < 8) {
      return "Must consist of at least 8 characters";
    } else {
      return null;
    }
  }

  String _getPasswordHelper() {
    final text = _passwordController.text.trim();
    String helper = '';
    _passwordStrengthScore = 9;
    if (text.length < 8) {
      helper += '\n▆ At least 8 characters!';
      _passwordStrengthScore -= 5;
    }
    if (!Accounts.hasLowerCase(text)) {
      helper += '\n▆ Should contain lowercase letters';
      _passwordStrengthScore--;
    }
    if (!Accounts.hasUpperCase(text)) {
      helper += '\n▆ Should contain uppercase letters';
      _passwordStrengthScore--;
    }
    if (!Accounts.hasDigits(text)) {
      helper += '\n▆ Should contain digits';
      _passwordStrengthScore--;
    }
    if (!Accounts.hasSpecialChar(text)) {
      helper += '\n▆ Should contain special characters';
      _passwordStrengthScore--;
    }
    return helper;
  }

  String? _getConfirmedPasswordError() {
    final text = _confirmedPasswordController.text.trim();
    if (text != _passwordController.text.trim()) {
      return "Passwords don't match";
    } else {
      return null;
    }
  }

  String? _getConfirmedPasswordHelper() {
    final text = _confirmedPasswordController.value.text.trim();
    if (text != _passwordController.value.text) {
      return "▆ Passwords should match!";
    }
    return null;
  }

  String? _getNameHelper(String text) {
    if (text.length < 3) {
      return "\n▆ Must consist of at least 3 letters";
    }
    if (text.length > 19) {
      return "\n▆ Name exceeds the limit!";
    }
    return null;
  }

  String? _getNameError(String text) {
    if (text.isEmpty) {
      return "\nCan not be empty!";
    }
    if (!Accounts.hasCharsOnly(text)) {
      return "\nName should only consist of english letters!";
    }
    if (text.length < 3) {
      return "\nName should consist of at least 3 letters";
    }
    return null;
  }

  String? _getMobileNumberError() {
    final String text = _phoneNumberController.text.trim();
    if (text.length != 11) {
      return "Invalid mobile number";
    }
    return null;
  }

  void _changePasswordVisibility() {
    setState(() {
      _passwordIsVisible = !_passwordIsVisible;
    });
  }

  void _changeConfirmedPasswordVisibility() {
    setState(() {
      _confirmedPasswordIsVisible = !_confirmedPasswordIsVisible;
    });
  }

  void _nextBottonTapped() async {
    if (!_errorFree()) {
      _showError = true;
      setState(() {});
    } else if (_screenIndex < 3) {
      _screenIndex++;
      _showError = false;
      if (_screenIndex == 1) {
        _backButtonTitle = 'Back';
      } else if (_screenIndex == 2) {
        _screenIndex--;
        setState(() {
          isAuthenticating = true;
        });
        await emailAuthentication(_emailController.text.trim());
      } else if (_screenIndex == 3) {
        //_screenIndex--;
        //await phoneAuthentication("+2${_phoneNumberController.text.trim()}");
      }
      setState(() {});
    } else if (_screenIndex == 3) {
      //Register code
      UserAccountModel newUser = UserAccountModel(
          id: "id",
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          phoneNumber: _phoneNumberController.text.trim(),
          rate: 5,
          raters: 0,
          locations: [],
          creationDate: (DateFormat.yMMMd().format(DateTime.now())).toString());
      setState(() {
        isAuthenticating = true;
      });
      await _createUserAccount(newUser);
    }
  }

  Future<void> emailAuthentication(String email) async {
    String check = await AuthenticationRepository.checkIfEmailIsInUse(email);
    if (check != "Availble") {
      _showErrorMessage(check);
    } else {
      _screenIndex++;
    }
    setState(() {
      isAuthenticating = false;
    });
  }

  /*Future<void> phoneAuthentication(String phoneNumber) async {
    String? error =
        await AuthenticationRepository.phoneAuthentication(phoneNumber);
    print("Errrrrrorrrrrr is $error");
    if (error != null) {
      _showErrorMessage(error);
    } else {
      _pushOTPScreen();
    }
  }

  Future<void> _pushOTPScreen() async {
    Navigator.push(context,
        CustomPageRoute(child: OTPScreen(isVerified: _isVerifiedPhoneNumber)));
  }

  void _isVerifiedPhoneNumber(bool check) {
    if (!check) {
      _showErrorMessage("Incorrect. Try again");
    } else {
      _screenIndex++;
      _showMessage("Confirmed");
    }
  }*/

  Future<void> _createUserAccount(UserAccountModel newUser) async {
    bool check = await UserRepository.createUser(newUser);
    if (check) {
      widget.whenLogin();
      _showMessage("Account has been successfully created");
    } else {
      _showErrorMessage("Something went wrong. Try again");
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

  void _backButtonTapped() {
    if (_screenIndex == 0) {
      //back to first page code
      widget.onBackButtonTap();
    } else {
      setState(() {
        _screenIndex--;
        _showError = false;
        if (_screenIndex == 0) {
          _backButtonTitle = 'Cancel';
        }
      });
    }
  }

  bool _errorFree() {
    switch (_screenIndex) {
      case 0:
        return (_getNameError(_firstNameController.value.text) == null &&
            _getNameError(_lastNameController.value.text) == null);
      case 1:
        return _getEmailError() == null;
      case 2:
        return _getMobileNumberError() == null;
      case 3:
        return (_getPasswordError() == null &&
            _getConfirmedPasswordError() == null);
      default:
        return false;
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmedPasswordController.dispose();
    super.dispose();
  }

  List<Widget> ProgressWidget() {
    List<Widget> progressList = [];
    for (int i = 0; i < 4; i++) {
      (i == _screenIndex)
          ? progressList.add(Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Theme.of(context).colorScheme.secondary)))
          : progressList.add(Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.black26)));
    }
    return progressList;
  }

  @override
  Widget build(context) {
    screenHeight = (MediaQuery.of(context).size.height);
    //- (MediaQuery.of(context).padding.top) -
    // (MediaQuery.of(context).padding.bottom);
    screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _emailController,
          _passwordController,
          _confirmedPasswordController,
          _firstNameController,
          _lastNameController
        ]),
        builder: (context, __) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              color: const Color.fromARGB(255, 245, 196, 63),
              height: MediaQuery.of(context).size.height,
              width: screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.1),
                  SizedBox(
                      width: screenWidth * 0.8,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: _backButtonTapped,
                              icon: Icon(Icons.arrow_back_ios_new_rounded,
                                  color:
                                      Theme.of(context).colorScheme.secondary)),
                          Text(_backButtonTitle,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary)),
                        ],
                      )),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  SizedBox(
                      width: 105,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: ProgressWidget())),
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  (_screenIndex == 0)
                      ? NameFields(
                          firstNameController: _firstNameController,
                          lastNameController: _lastNameController,
                          firstNameError:
                              _getNameError(_firstNameController.value.text),
                          lastNameError:
                              _getNameError(_lastNameController.value.text),
                          firstNameHelper:
                              _getNameHelper(_firstNameController.value.text),
                          lastNameHelper:
                              _getNameHelper(_lastNameController.value.text),
                          showError: _showError,
                          onButtonTap: _nextBottonTapped,
                          buttonTitle: "Next")
                      : (_screenIndex == 1)
                          ? EmailField(
                              controller: _emailController,
                              error: _getEmailError(),
                              showError: _showError,
                              onButtonTap: _nextBottonTapped,
                              buttonTitle: "Next")
                          : (_screenIndex == 2)
                              ? MobileNumberFields(
                                  controller: _phoneNumberController,
                                  error: _getMobileNumberError(),
                                  showError: _showError,
                                  buttonTitle: "Next",
                                  onButtonTap: _nextBottonTapped,
                                )
                              : //screeIndex = 3
                              RegisterPasswordTextFields(
                                  passwordController: _passwordController,
                                  passwordIsVisible: _passwordIsVisible,
                                  passwordError: _getPasswordError(),
                                  passwordHelper: _getPasswordHelper(),
                                  passwordOnTap: _changePasswordVisibility,
                                  confirmedPasswordController:
                                      _confirmedPasswordController,
                                  confirmedPasswordIsVisible:
                                      _confirmedPasswordIsVisible,
                                  confirmedPasswordError:
                                      _getConfirmedPasswordError(),
                                  confirmedPasswordHelper:
                                      _getConfirmedPasswordHelper(),
                                  confirmedPasswordOnTap:
                                      _changeConfirmedPasswordVisibility,
                                  showError: _showError,
                                  passwordStrengthScore: _passwordStrengthScore,
                                  onButtonTap: _nextBottonTapped,
                                  buttonTitle: "Sign up"),
                  SizedBox(height: screenHeight * 0.05),
                  isAuthenticating
                      ? CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.secondary)
                      : const SizedBox()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
