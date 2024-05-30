import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_gmf/Screens/dashboard_page.dart';
import 'package:mobile_gmf/Screens/signIn_page.dart';
import 'package:mobile_gmf/Screens/splash_page.dart';
import 'package:mobile_gmf/Theme.dart';
// import '';
void main() {
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: primaryColor,
          appBarTheme: AppBarTheme(
              backgroundColor: lightBackgroundColor,
              centerTitle: false,
              elevation: 1,
              titleTextStyle: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
              iconTheme: IconThemeData(color: blackColor))),
      home: const SplashPage(),
      routes: {
        // '/': (context) => const SplashPage(),
        '/signin': (context) => const SignInPage(),
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
}
