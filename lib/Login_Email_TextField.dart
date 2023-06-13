import 'package:flutter/material.dart';
import 'package:test_app/register/Register_Next_Button.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final String? error;
  final bool showError;
  final void Function() onButtonTap;
  final String buttonTitle;

  const EmailField(
      {super.key,
      required this.controller,
      required this.error,
      required this.showError,
      required this.onButtonTap,
      required this.buttonTitle});

  @override
  Widget build(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextField(
            controller: controller,
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
                labelText: 'E-mail',
                labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold),
                errorText: showError ? error : null,
                hintText: 'Enter your Email',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.mail,
                  color: Theme.of(context).colorScheme.secondary,
                )),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        NextButton(onTap: onButtonTap, title: buttonTitle)
      ],
    );
  }
}
