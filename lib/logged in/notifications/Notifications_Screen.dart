import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  @override
  State<NotificationsScreen> createState() {
    return _NotificationsScreenState();
  }
}

class _NotificationsScreenState extends State<NotificationsScreen> {
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
                child: Text("Notifications",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge),
              ),
            )),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
              Text(
                'Notifications',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              )
            ])));
  }
}
