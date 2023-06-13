import 'package:flutter/material.dart';

class Dialogs {
  static Future<void> showCustomizedTextDialog(
      BuildContext context,
      void Function() onConfirm,
      String contentText,
      String confirmTitle,
      String cancelTitle) async {
    Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      style: TextButton.styleFrom(
        fixedSize: const Size(80, 6),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            side: BorderSide(
                width: 1.5, color: Color.fromARGB(255, 255, 255, 255))),
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      ),
      child: Text(cancelTitle,
          style: const TextStyle(color: Colors.white, fontSize: 14)),
    );
    Widget confirmButton = TextButton(
      onPressed: () {
        onConfirm();
        Navigator.pop(context);
      },
      style: TextButton.styleFrom(
          fixedSize: const Size(80, 6),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255)),
      child: Text(confirmTitle,
          style: const TextStyle(color: Colors.black54, fontSize: 14)),
    );
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      content: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Center(
            child: Text(
              contentText,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.black54),
            ),
          )),
      actions: [cancelButton, confirmButton],
      contentPadding: const EdgeInsets.all(0),
      actionsPadding: const EdgeInsets.only(top: 5),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async {
                return true;
              },
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: alert));
        });
  }

  static Future<void> showCustomizedTextFieldDialog(
      BuildContext context,
      void Function(String details) onConfirm,
      String contentText,
      String hintText,
      String confirmTitle,
      String cancelTitle) async {
    final TextEditingController controller = TextEditingController();
    Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      style: TextButton.styleFrom(
        fixedSize: const Size(80, 6),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            side: BorderSide(
                width: 1.5, color: Color.fromARGB(255, 255, 255, 255))),
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      ),
      child: Text(cancelTitle,
          style: const TextStyle(color: Colors.white, fontSize: 14)),
    );
    Widget confirmButton = TextButton(
      onPressed: () {
        onConfirm(controller.text.trim());
        Navigator.pop(context);
      },
      style: TextButton.styleFrom(
          fixedSize: const Size(80, 6),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255)),
      child: Text(confirmTitle,
          style: const TextStyle(color: Colors.black54, fontSize: 14)),
    );
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      content: Container(
          padding: EdgeInsets.all(25),
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(contentText),
              SizedBox(height: 10),
              TextField(
                controller: controller,
                maxLength: 200,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 8,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(color: Colors.black87, width: 1)),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(color: Colors.black87, width: 2)),
                  labelText: "Details",
                  labelStyle: const TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.bold),
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  hintText: hintText,
                  hintStyle:
                      const TextStyle(color: Colors.black45, fontSize: 14),
                ),
              )
            ],
          )),
      actions: [cancelButton, confirmButton],
      contentPadding: const EdgeInsets.all(0),
      actionsPadding: const EdgeInsets.only(top: 5),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async {
                return true;
              },
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: alert));
        });
  }
}
