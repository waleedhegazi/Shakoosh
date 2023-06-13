import 'package:flutter/material.dart';
import 'package:test_app/logged%20in/appointment/Appointments_Screen.dart';
import 'package:test_app/logged in/profile/Profile_Screen_Updater.dart';
import 'package:test_app/logged in/home/Home_Screen.dart';
import 'package:test_app/logged in/notifications/Notifications_Screen.dart';
import 'package:test_app/Shakoosh_icons.dart';
import 'package:test_app/repository/User_Repository.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});
  @override
  State<LandingPage> createState() {
    return _LandingPageState();
  }
}

class _LandingPageState extends State<LandingPage> {
  double screenHeight = 0;
  int _currentScreenIndex = 1;

  final List<Widget> screens = const [
    ProfileScreen(),
    HomeScreen(),
    NotificationsScreen(),
    AppointmentsScreen()
  ];

  @override
  void initState() {
    super.initState();
    UserRepository.updateAll();
  }

  void _onTap(int choice) {
    setState(() {
      _currentScreenIndex = choice;
    });
  }

  @override
  Widget build(context) {
    screenHeight = (MediaQuery.of(context).size.height) -
        (MediaQuery.of(context).padding.top) -
        (MediaQuery.of(context).padding.bottom);
    return Scaffold(
        body: screens[_currentScreenIndex],
        bottomNavigationBar: SizedBox(
          height: screenHeight * 0.09,
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Color.fromARGB(255, 245, 196, 63),
              unselectedItemColor: Colors.grey[350],
              selectedFontSize: 10,
              showUnselectedLabels: false,
              iconSize: 35,
              onTap: _onTap,
              currentIndex: _currentScreenIndex,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: "Notifications",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    ShakooshIcons.logo_transparent_black_2,
                  ),
                  label: "Appointments",
                ),
              ]),
        ));
  }
}
