import 'package:flutter/material.dart';
import 'package:test_app/data_models/User_Account_Model.dart';
import 'package:test_app/Login_Email_TextField.dart';
import 'package:test_app/register/Register_Password_TextFields.dart';
import 'package:test_app/register/Register_Name_TextFields.dart';
import 'package:test_app/register/Register_Next_Button.dart';
import 'package:test_app/Login_Password_TextField.dart';
import 'package:test_app/register/Register_Mobile_Number_Text_Field.dart';
import 'package:test_app/repository/User_Repository.dart';
import 'package:test_app/SnackBars.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  State<EditProfileScreen> createState() {
    return _EditProfileScreenState();
  }
}

UserAccountModel updated = UserAccountModel(
    id: '',
    firstName: UserRepository.getCurrentUser().getFirstName(),
    lastName: UserRepository.getCurrentUser().getLastName(),
    email: UserRepository.getCurrentUser().getEmail(),
    password: UserRepository.getCurrentUser().getPassword(),
    phoneNumber: UserRepository.getCurrentUser().getPhoneNumber(),
    creationDate: '',
    locations: []);

class _EditProfileScreenState extends State<EditProfileScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  final _emailController =
      TextEditingController(text: UserRepository.getCurrentUser().getEmail());
  final _firstNameController = TextEditingController(
      text: UserRepository.getCurrentUser().getFirstName());
  final _lastNameController = TextEditingController(
      text: UserRepository.getCurrentUser().getLastName());
  final _mobileNumberController = TextEditingController(
      text: UserRepository.getCurrentUser().getPhoneNumber());
  final _passwordController = TextEditingController();
  final _confirmedPasswordController = TextEditingController();
  final _confirmActionPasswordController = TextEditingController();
  bool _isInformationChanged = false;

  Widget currentScreen = const Text('init');
  bool _passwordIsVisible = false;
  bool _confirmedPasswordIsVisible = false;
  bool _confirmActionPasswordIsVisible = false;
  int _screenIndex = -1;
  bool _showError = false;
  int _passwordStrengthScore = 0;

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
    final text = _passwordController.text.trim();
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
    if (text != _passwordController.value.text) {
      return "Passwords don't match";
    } else {
      return null;
    }
  }

  String? _getConfirmedPasswordHelper() {
    final text = _confirmedPasswordController.text.trim();
    if (text != _passwordController.value.text) {
      return "▆ Passwords should match!";
    }
    return null;
  }

  String? _getConfirmActionPasswordError() {
    final text = _confirmActionPasswordController.text.trim();
    if (text != UserRepository.getCurrentUser().getPassword()) {
      return "Wrong password";
    } else {
      return null;
    }
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
    final String text = _mobileNumberController.text.trim();
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

  void _changeConfirmActionPasswordVisibility() {
    setState(() {
      _confirmActionPasswordIsVisible = !_confirmActionPasswordIsVisible;
    });
  }

  bool _isErrorFree() {
    switch (_screenIndex) {
      case 0:
        return (_getNameError(_firstNameController.text.trim()) == null &&
            _getNameError(_lastNameController.text.trim()) == null);
      case 1:
        return _getEmailError() == null;
      case 2:
        return _getMobileNumberError() == null;
      case 3:
        return (_getPasswordError() == null &&
            _getConfirmedPasswordError() == null);
      case -2:
        return _getConfirmActionPasswordError() == null;
      default:
        return false;
    }
  }

  void _onSubmitTap() {
    setState(() {
      if (!_isErrorFree()) {
        _showError = true;
      } else {
        _showError = false;

        switch (_screenIndex) {
          case 0:
            if (updated.getFirstName() != _firstNameController.text.trim() ||
                updated.getLastName() != _lastNameController.text.trim()) {
              updated.setFirstName(_firstNameController.text.trim());
              updated.setLastName(_lastNameController.text.trim());
              _isInformationChanged = true;
            }

            break;
          case 1:
            if (updated.getEmail() != _emailController.text.trim()) {
              updated.setEmail(_emailController.text.trim());
              _isInformationChanged = true;
            }

            break;
          case 2:
            if (updated.getPhoneNumber() !=
                _mobileNumberController.text.trim()) {
              updated.setPhoneNumber(_mobileNumberController.text.trim());
              _isInformationChanged = true;
            }

            break;
          case 3:
            if (updated.getPassword() != _passwordController.text.trim()) {
              updated.setPassword(_passwordController.text.trim());
              _isInformationChanged = true;
            }
        }
        if (_isInformationChanged) {
          _screenIndex = -2;
        } else {
          _screenIndex = -1;
        }
      }
    });
  }

  void _onSaveChangesTap() {
    if (_isErrorFree()) {
      setState(() {
        _showError = false;
        UserRepository.getCurrentUser()
            .setFirstName(_firstNameController.text.trim());
        UserRepository.getCurrentUser()
            .setLastName(_lastNameController.text.trim());
        UserRepository.getCurrentUser().setEmail(_emailController.text.trim());
        if (_passwordController.text.trim().isNotEmpty) {
          UserRepository.getCurrentUser()
              .setPassword(_passwordController.text.trim());
        }
        UserRepository.getCurrentUser()
            .setPhoneNumber(_mobileNumberController.text.trim());
        UserRepository.updateProfileInfoInDatabase();
        //save changes to database
        //_screenIndex = -1;
        Navigator.pop(context);
      });
      SnackBars.showMessage(context, 'Profile is updated');
    } else {
      setState(() {
        _showError = true;
      });
    }
  }

  void _onEditTap(int choice) {
    setState(() {
      switch (choice) {
        case 0:
          _screenIndex = 0;

          break;
        case 1:
          _screenIndex = 1;

          break;
        case 2:
          _screenIndex = 2;

          break;
        case 3:
          _screenIndex = 3;
          break;
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileNumberController.dispose();
    _passwordController.dispose();
    _confirmedPasswordController.dispose();
    _confirmActionPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    screenHeight = (MediaQuery.of(context).size.height) -
        (MediaQuery.of(context).padding.top) -
        (MediaQuery.of(context).padding.bottom);
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight * 0.07),
            child: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    SnackBars.showMessage(context, 'No changes are made');
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                  )),
              title: Text("Edit profile",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge),
            )),
        body: SizedBox(
          child: SingleChildScrollView(
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _emailController,
                _passwordController,
                _confirmedPasswordController,
                _firstNameController,
                _lastNameController,
                _confirmActionPasswordController,
                _mobileNumberController,
              ]),
              builder: (context, __) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                      //color: const Color.fromARGB(255, 245, 196, 63),
                      height: screenHeight * 0.92,
                      width: screenWidth,
                      child: (_screenIndex == -2)
                          ? Column(
                              children: [
                                EditProfileMainScreen(onEditTap: _onEditTap),
                                SizedBox(
                                  height: screenHeight * 0.05,
                                ),
                                Column(children: [
                                  SizedBox(
                                    //height: screenHeight * 0.1,
                                    width: screenWidth * 0.9,
                                    child: PasswordField(
                                      controller:
                                          _confirmActionPasswordController,
                                      isVisible:
                                          _confirmActionPasswordIsVisible,
                                      iconOnTap:
                                          _changeConfirmActionPasswordVisibility,
                                      error: _getConfirmActionPasswordError(),
                                      label: "Password",
                                      hint: "Enter your password",
                                      showError: _showError,
                                      passwordStrengthScore: 0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.05,
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.4,
                                    child: NextButton(
                                        onTap: _onSaveChangesTap,
                                        title: 'Save changes'),
                                  ),
                                ]),
                              ],
                            )
                          : (_screenIndex == -1)
                              ? EditProfileMainScreen(onEditTap: _onEditTap)
                              : (_screenIndex == 0)
                                  ? NameFields(
                                      firstNameController: _firstNameController,
                                      lastNameController: _lastNameController,
                                      firstNameError: _getNameError(
                                          _firstNameController.value.text),
                                      lastNameError: _getNameError(
                                          _lastNameController.value.text),
                                      firstNameHelper: _getNameHelper(
                                          _firstNameController.value.text),
                                      lastNameHelper: _getNameHelper(
                                          _lastNameController.value.text),
                                      showError: _showError,
                                      buttonTitle: "Submit",
                                      onButtonTap: _onSubmitTap,
                                    )
                                  : (_screenIndex == 1)
                                      ? EmailField(
                                          controller: _emailController,
                                          error: _getEmailError(),
                                          showError: _showError,
                                          buttonTitle: "Submit",
                                          onButtonTap: _onSubmitTap,
                                        )
                                      : (_screenIndex == 2)
                                          ? MobileNumberFields(
                                              controller:
                                                  _mobileNumberController,
                                              error: _getMobileNumberError(),
                                              showError: _showError,
                                              buttonTitle: "Submit",
                                              onButtonTap: _onSubmitTap,
                                            )
                                          : // screenIndex = 3
                                          RegisterPasswordTextFields(
                                              passwordController:
                                                  _passwordController,
                                              passwordIsVisible:
                                                  _passwordIsVisible,
                                              passwordError:
                                                  _getPasswordError(),
                                              passwordHelper:
                                                  _getPasswordHelper(),
                                              passwordOnTap:
                                                  _changePasswordVisibility,
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
                                              passwordStrengthScore:
                                                  _passwordStrengthScore,
                                              onButtonTap: _onSubmitTap,
                                              buttonTitle: 'Submit')),
                );
              },
            ),
          ),
        ));
  }
}

class EditProfileMainScreen extends StatelessWidget {
  final void Function(int index) onEditTap;

  const EditProfileMainScreen({required this.onEditTap, super.key});

  @override
  Widget build(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        EditProfileListTile(
            icon: const Icon(Icons.person, color: Colors.black87),
            description: 'Name',
            title: "${updated.getFirstName()} ${updated.getLastName()}",
            index: 0,
            onArrowTap: onEditTap),
        EditProfileListTile(
            icon: const Icon(Icons.email_rounded, color: Colors.black87),
            description: 'E-mail',
            title: updated.getEmail(),
            index: 1,
            onArrowTap: onEditTap),
        EditProfileListTile(
            icon: const Icon(Icons.phone, color: Colors.black87),
            description: 'Mobile number',
            title: updated.getPhoneNumber(),
            index: 2,
            onArrowTap: onEditTap),
        EditProfileListTile(
            icon: const Icon(Icons.lock_person_rounded, color: Colors.black87),
            description: 'Password',
            title: "⦿⦿⦿⦿⦿⦿⦿⦿⦿⦿⦿⦿",
            index: 3,
            onArrowTap: onEditTap),
      ],
    );
  }
}

class EditProfileListTile extends StatelessWidget {
  final String description;
  final Icon icon;
  final String title;
  final int index;
  final void Function(int index) onArrowTap;
  const EditProfileListTile(
      {required this.description,
      required this.icon,
      required this.title,
      required this.index,
      required this.onArrowTap,
      super.key});

  @override
  Widget build(context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: const Color.fromARGB(66, 109, 104, 104),
            borderRadius: BorderRadius.circular(30)),
        child: ListTile(
          leading: Container(
              height: MediaQuery.of(context).size.width * 0.1,
              width: MediaQuery.of(context).size.width * 0.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white),
              child: icon),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(description,
                  style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 5,
              ),
              Text(title,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.secondary)),
            ],
          ),
          trailing: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.transparent),
              onPressed: () {
                onArrowTap(index);
              },
              child: Text("Edit",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold))),
        ));
  }
}
