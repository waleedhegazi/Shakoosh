import 'package:flutter/material.dart';
import 'package:test_app/logged in/profile/Main_Profile_Screen.dart';
import 'package:test_app/repository/Authentication_Repository.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:test_app/repository/User_Repository.dart';
import 'package:test_app/SnackBars.dart';
import 'package:test_app/Shakoosh_icons.dart';
import 'package:test_app/Dialogs.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  Widget activeScreen = const Text('init');
  String appBarTitle = 'Profile';
  File? pickedImageFile;
  @override
  void initState() {
    activeScreen = MainProfileScreen(
      onLogOutTap: _onLogOutTap,
      onChangePhotoTap: _onChangePhotoTap,
    );
    super.initState();
  }

  void _onRemoveCurrentPhoto() async {
    try {
      await UserRepository.removeProfilePic().whenComplete(() {
        SnackBars.showMessage(context, "Profile picture is removed");
      });
    } catch (e) {
      SnackBars.showErrorMessage(context, "Something went wrong. Try again");
    }
    setState(() {});
  }

  void _onNewPhotoFromCamera() async {
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 30,
        maxWidth: 200,
        maxHeight: 200);
    if (pickedImage != null) {
      pickedImageFile = File(pickedImage.path);
      try {
        await UserRepository.addProfilePic(pickedImageFile!).whenComplete(() {
          SnackBars.showMessage(context, "Profile picture is updated");
        });
      } catch (e) {
        SnackBars.showErrorMessage(context, "Something went wrong. Try again");
      }

      setState(() {});
    }
  }

  void _onNewPhotoFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 30,
        maxWidth: 200,
        maxHeight: 200);
    if (pickedImage != null) {
      pickedImageFile = File(pickedImage.path);
      try {
        await UserRepository.addProfilePic(pickedImageFile!).whenComplete(() {
          SnackBars.showMessage(
              context, "Profile picture will be updated in seconds");
        });
      } catch (e) {
        SnackBars.showErrorMessage(context, "Something went wrong. Try again");
      }
      setState(() {});
    }
  }

  void _onChangePhotoTap(int option) {
    switch (option) {
      case 0:
        _onNewPhotoFromCamera();
        break;
      case 1:
        _onNewPhotoFromGallery();
        break;
      case 2:
        Dialogs.showCustomizedTextDialog(context, _onRemoveCurrentPhoto,
            "Remove profile picture?", "Confirm", "Cancel");
    }
  }

  void _onLogOutTap() {
    AuthenticationRepository.signOut();
    SnackBars.showMessage(context, "Signed out");
  }

  @override
  Widget build(context) {
    double screenHeight = (MediaQuery.of(context).size.height) -
        (MediaQuery.of(context).padding.top) -
        (MediaQuery.of(context).padding.bottom);
    double screenWidth = (MediaQuery.of(context).size.width);
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight * 0.07),
            child: AppBar(
              title: SizedBox(
                width: screenWidth,
                child: Text(appBarTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge),
              ),
            )),
        body: activeScreen);
  }
}
