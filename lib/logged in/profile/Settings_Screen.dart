import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_app/main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = (MediaQuery.of(context).size.height) -
        (MediaQuery.of(context).padding.top) -
        (MediaQuery.of(context).padding.bottom);
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDark = MyApp.themeNotifier.value == ThemeMode.dark;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight * 0.07),
            child: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                  )),
              title: Text("Settings",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge),
            )),
        body: Container(
            margin: EdgeInsets.all(screenWidth * 0.1),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isDark ? 'Switch to light mood' : 'Switch to dark mood',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      CupertinoSwitch(
                        value: isDark,
                        onChanged: (_) {
                          MyApp.themeNotifier.value =
                              isDark ? ThemeMode.light : ThemeMode.dark;
                        },
                        thumbColor: Color.fromARGB(255, 245, 196, 63),
                        trackColor: Colors.black87,
                        activeColor: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: screenWidth * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Change the language',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Row(
                        children: [
                          Text('English '),
                          CupertinoSwitch(
                            value: false,
                            onChanged: (_) {},
                            thumbColor: Color.fromARGB(255, 245, 196, 63),
                            trackColor: Color.fromARGB(255, 201, 200, 200),
                            activeColor: Color.fromARGB(255, 201, 200, 200),
                          ),
                        ],
                      ),
                    ],
                  ),
                ])));
  }
}
