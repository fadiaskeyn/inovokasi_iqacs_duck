import 'dart:async';

import 'package:mobile_gmf/Theme.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    //
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushNamedAndRemoveUntil(
          context, '/signin', (route) => false);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const OnBoardingPage(),
      //   ),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenColor,
      body: Center(
        child: Container(
          height: 209,
          width: 209,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/gmf.png'))),
        ),
      ),
    );
  }
}
