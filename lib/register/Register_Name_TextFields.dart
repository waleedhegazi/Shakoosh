import 'package:flutter/material.dart';
import 'package:test_app/register/Register_Next_Button.dart';

class NameFields extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final String? firstNameHelper;
  final String? lastNameHelper;
  final String? firstNameError;
  final String? lastNameError;
  final bool showError;
  final void Function() onButtonTap;
  final String buttonTitle;

  const NameFields(
      {required this.firstNameController,
      required this.lastNameController,
      required this.firstNameError,
      required this.lastNameError,
      required this.firstNameHelper,
      required this.lastNameHelper,
      required this.showError,
      required this.onButtonTap,
      required this.buttonTitle,
      super.key});
  @override
  Widget build(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextField(
            maxLength: 15,
            controller: firstNameController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 3)),
              errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 167, 34, 24), width: 1)),
              focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 167, 34, 24), width: 3)),
              errorStyle:
                  const TextStyle(color: Color.fromARGB(255, 167, 34, 24)),
              labelText: "First name",
              labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold),
              hintText: "Enter your first name",
              hintStyle: const TextStyle(color: Colors.grey),
              helperText: firstNameHelper,
              helperStyle: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
              errorText: showError ? firstNameError : null,
              prefixIcon: Icon(Icons.person,
                  color: Theme.of(context).colorScheme.secondary),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.1,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextField(
              maxLength: 15,
              controller: lastNameController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 3)),
                errorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 167, 34, 24), width: 1)),
                focusedErrorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 167, 34, 24), width: 3)),
                errorStyle:
                    const TextStyle(color: Color.fromARGB(255, 167, 34, 24)),
                labelText: "Last name",
                labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold),
                hintText: "Enter your last name",
                hintStyle: const TextStyle(color: Colors.grey),
                helperText: lastNameHelper,
                helperStyle: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                errorText: showError ? lastNameError : null,
                prefixIcon: Icon(Icons.person,
                    color: Theme.of(context).colorScheme.secondary),
              )),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        NextButton(onTap: onButtonTap, title: buttonTitle)
      ],
    );
  }
}
