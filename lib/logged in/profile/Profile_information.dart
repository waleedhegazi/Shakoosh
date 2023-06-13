import 'package:flutter/material.dart';
import 'package:test_app/repository/User_Repository.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class ProfileInformation extends StatelessWidget {
  final void Function(int option) onChangePhotoTap;
  const ProfileInformation({required this.onChangePhotoTap, super.key});

  @override
  Widget build(context) {
    double screenHeight = (MediaQuery.of(context).size.height) -
        (MediaQuery.of(context).padding.top) -
        (MediaQuery.of(context).padding.bottom);
    return SizedBox(
      height: screenHeight * 0.4,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                SizedBox(
                  height: screenHeight * 0.2,
                  width: screenHeight * 0.2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: UserRepository.getCurrentUser().getProfilePic(),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                      width: 45,
                      height: 45,
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, left: 9, right: 1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Theme.of(context).colorScheme.tertiary),
                      child: DropDownOptions(onOptionTap: onChangePhotoTap)),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              "${UserRepository.getCurrentUser().getFirstName()} ${UserRepository.getCurrentUser().getLastName()}",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(UserRepository.getCurrentUser().getRate().toString(),
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(
                  width: 2,
                ),
                SizedBox(
                    width: 15,
                    height: 15,
                    child: UserRepository.getCurrentUser().getStar()),
                const SizedBox(
                  width: 10,
                ),
                Text(UserRepository.getCurrentUser().getRaters().toString(),
                    style: Theme.of(context).textTheme.bodyLarge),
                SizedBox(width: 2),
                const Icon(Icons.people_alt, size: 18)
              ],
            ),
            const SizedBox(height: 10),
            Text(
              UserRepository.getCurrentUser().getEmail(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.phone, size: 18),
              const SizedBox(
                width: 5,
              ),
              Text(
                UserRepository.getCurrentUser().getPhoneNumberFormatted(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(width: 10)
            ]),
          ]),
    );
  }
}

class DropDownOptions extends StatelessWidget {
  final void Function(int option) onOptionTap;
  DropDownOptions({required this.onOptionTap, super.key});

  final optoinsList =
      (UserRepository.getCurrentUser().getProfilePicURL() != null)
          ? MenuItems.menuItems
          : MenuItems.menuItemsWithoutRemove;

  @override
  Widget build(context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Icon(Icons.camera_alt,
            color: Theme.of(context).colorScheme.secondary, size: 20),
        items: [
          ...optoinsList.map((item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: Row(
                children: [
                  item.getOptionIcon(),
                  const SizedBox(
                    width: 10,
                  ),
                  item.getOptionText(),
                ],
              )))
        ],
        onChanged: (item) {
          if (item != null) {
            onOptionTap(item.getIndex());
          }
        },
        dropdownStyleData: DropdownStyleData(
          width: 120,
          padding: const EdgeInsets.symmetric(vertical: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: const Color.fromARGB(255, 245, 196, 63),
          ),
          elevation: 8,
          offset: const Offset(2, 8),
        ),
      ),
    );
  }
}

class MenuItem {
  final Text optionText;
  final Icon optionIcon;
  final int index;
  const MenuItem(
      {required this.index,
      required this.optionText,
      required this.optionIcon});
  Text getOptionText() {
    return optionText;
  }

  Icon getOptionIcon() {
    return optionIcon;
  }

  int getIndex() {
    return index;
  }
}

class MenuItems {
  static const MenuItem camera = MenuItem(
      index: 0,
      optionText: Text(
        'Camera',
        style: TextStyle(
            color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
      ),
      optionIcon: Icon(Icons.camera, color: Colors.black));
  static const MenuItem gallery = MenuItem(
      index: 1,
      optionText: Text('Gallery',
          style: TextStyle(
              color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
      optionIcon: Icon(Icons.photo_camera_back, color: Colors.black));
  static const MenuItem remove = MenuItem(
      index: 2,
      optionText: Text('Remove',
          style: TextStyle(
              color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
      optionIcon: Icon(Icons.delete, color: Colors.black));
  static final List<MenuItem> menuItems = [camera, gallery, remove];
  static final List<MenuItem> menuItemsWithoutRemove = [
    camera,
    gallery,
  ];
}
