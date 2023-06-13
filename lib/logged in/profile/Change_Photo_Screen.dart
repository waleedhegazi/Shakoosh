import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import "package:test_app/Assets.dart";

class ChangePhotoScreen extends StatefulWidget {
  const ChangePhotoScreen({super.key});
  @override
  State<ChangePhotoScreen> createState() {
    return _ChangePhotoScreenState();
  }
}

class _ChangePhotoScreenState extends State<ChangePhotoScreen> {
  File? pickedImageFile;
  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 400,
        maxHeight: 400);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      pickedImageFile = File(pickedImage.path);
    });
  }

  @override
  Widget build(context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage: pickedImageFile != null
              ? FileImage(pickedImageFile!)
              : Assets.anonymousImage.image,
        ),
        TextButton.icon(
            onPressed: _pickImage,
            icon: const Icon(Icons.image),
            label: const Text("Add Image"))
      ],
    );
  }
}
