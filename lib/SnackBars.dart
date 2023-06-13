import 'package:test_app/Shakoosh_icons.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:flutter/material.dart';

class SnackBars {
  static void showConfirmedMessage(BuildContext context, String txt) {
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

  static void showErrorMessage(BuildContext context, String txt) {
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

  static void showMessage(BuildContext context, String txt) {
    showTopSnackBar(
        Overlay.of(context),
        Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(20)),
            child: SizedBox(
              height: 50,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(ShakooshIcons.logo_transparent_black_2,
                    size: 40, color: Theme.of(context).colorScheme.tertiary),
                Container(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(txt,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.tertiary)))
              ]),
            )));
  }
}
