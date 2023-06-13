import 'package:flutter/material.dart';

class GetHelpScreen extends StatelessWidget {
  const GetHelpScreen({super.key});

  @override
  Widget build(context) {
    double screenHeight = (MediaQuery.of(context).size.height) -
        (MediaQuery.of(context).padding.top) -
        (MediaQuery.of(context).padding.bottom);
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight * 0.07),
            child: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                  )),
              title: Text("Get help",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge),
            )),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
              Text(
                'Manual',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              )
            ])));
  }
}
