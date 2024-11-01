import 'dart:async';

// import 'package:mobile_gmf/Screens/backupdashboard.dart';
import 'package:mobile_gmf/Screens/dashboard_page.dart';
import 'package:mobile_gmf/Screens/signIn_page.dart';
import 'package:mobile_gmf/Theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var keyLogin;
  var token;
  @override
  void initState() {
    //
    super.initState();
    Timer(const Duration(seconds: 2), () => checktoken());
  }

  Future<void> checktoken() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    keyLogin = prefs.getString('keyLogin');
    runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: greenColor,
            appBarTheme: AppBarTheme(
                backgroundColor: greenColor,
                centerTitle: false,
                elevation: 1,
                titleTextStyle: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
                iconTheme: IconThemeData(color: blackColor))),

        // },
        home: token == null ? const SignInPage() : const DashboardPage()));
    // home: token == null ? const MaintenancePage() : const MaintenancePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: darkBrown, // Warna background
          image: DecorationImage(
            image: AssetImage('assets/bgss.png'), // Gambar background
            fit: BoxFit.cover, // Mengatur agar gambar mengisi kontainer
          ),
        ),
        child: Center(
          child: Container(
            height: 209,
            width: 209,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/duck.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
