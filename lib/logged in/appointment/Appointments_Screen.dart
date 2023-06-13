import 'package:flutter/material.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});
  @override
  State<AppointmentsScreen> createState() {
    return _AppointmentsScreenState();
  }
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
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
                child: Text("My appointments",
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
                'My appointments',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              )
            ])));
  }
}
