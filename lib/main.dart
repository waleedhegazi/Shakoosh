import 'package:flutter/material.dart';
import 'package:test_app/Auth_Updater.dart';
import 'package:test_app/logged in/Landing_Page.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_app/Splash_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

final ColorScheme lightColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor:  Color.fromARGB(255, 245, 196, 63),
    primary: const Color.fromARGB(255, 245, 196, 63),
    secondary: Color.fromARGB(255, 46, 46, 46),
    tertiary: const Color.fromARGB(255, 255, 255, 255),
    shadow: Colors.grey,
    tertiaryContainer: const Color.fromARGB(200, 46, 46, 46));
final ColorScheme darkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 245, 196, 63),
    primary: const Color.fromARGB(255, 245, 196, 63),
    secondary: const Color.fromARGB(255, 255, 255, 255),
    tertiary: const Color.fromARGB(255, 46, 46, 46),
    shadow: const Color.fromARGB(100, 245, 196, 63)),
    tertiaryContainer: const Color.fromARGB(200, 255, 255, 255);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  @override
  Widget build(context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
              themeMode: currentMode,
              darkTheme: ThemeData().copyWith(
                  useMaterial3: true,
                  colorScheme: darkColorScheme,
                  scaffoldBackgroundColor: darkColorScheme.tertiary,
                  appBarTheme: const AppBarTheme().copyWith(
                      backgroundColor: darkColorScheme.tertiary,
                      foregroundColor: darkColorScheme.secondary),
                  cardTheme: const CardTheme().copyWith(
                      color: Color.fromARGB(255, 97, 97, 97),
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10)),
                  textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                          backgroundColor: darkColorScheme.primary,
                          shape: const StadiumBorder())),
                  textTheme: const TextTheme().copyWith(
                      titleLarge: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: darkColorScheme.secondary),
                      bodyLarge: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: darkColorScheme.secondary),
                      bodyMedium: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: darkColorScheme.secondary),
                      bodySmall: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: darkColorScheme.secondary,
                      ),
                      displaySmall: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: darkColorScheme.secondary,
                      ),
                      displayLarge: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: darkColorScheme.secondary,
                      )),
                  iconTheme: const IconThemeData()
                      .copyWith(size: 20, color: darkColorScheme.secondary),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData()
                      .copyWith(backgroundColor: darkColorScheme.tertiary)),
              theme: ThemeData().copyWith(
                  useMaterial3: true,
                  colorScheme: lightColorScheme,
                  scaffoldBackgroundColor: lightColorScheme.tertiary,
                  appBarTheme: const AppBarTheme().copyWith(
                      backgroundColor: lightColorScheme.tertiary,
                      foregroundColor: lightColorScheme.secondary),
                  cardTheme: const CardTheme().copyWith(
                      color: lightColorScheme.secondaryContainer,
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10)),
                  textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                          backgroundColor: lightColorScheme.primary,
                          shape: const StadiumBorder())),
                  textTheme: const TextTheme().copyWith(
                      titleLarge: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: lightColorScheme.secondary),
                      bodyLarge: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: lightColorScheme.secondary),
                      bodyMedium: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: lightColorScheme.secondary),
                      bodySmall: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: lightColorScheme.secondary,
                      ),
                      displaySmall: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: lightColorScheme.secondary,
                      ),
                      displayLarge: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: lightColorScheme.secondary,
                      )),
                  iconTheme: const IconThemeData()
                      .copyWith(size: 20, color: lightColorScheme.secondary),
                  bottomNavigationBarTheme: const BottomNavigationBarThemeData()
                      .copyWith(backgroundColor: lightColorScheme.tertiary)),
              //the default
              home: StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SplashScreen(textMessage: "Loading");
                    } else if (snapshot.hasData) {
                      return const LandingPage();
                    } else {
                      return const AuthUpdater();
                    }
                  }));
        });
  }
}
