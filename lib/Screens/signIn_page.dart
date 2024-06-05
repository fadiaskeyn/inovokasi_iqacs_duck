import 'package:flutter/material.dart';
import 'package:mobile_gmf/Theme.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  void initState() {
    super.initState();
    String user = 'test';
  }

  Future<void> toDashboard() async {
    Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.only(
                top: 100,
                bottom: 50,
              ),
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/gmf.png'))),
            ),
            Text('Halo',
                textAlign: TextAlign.center,
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                )),
            const SizedBox(
              height: 8,
            ),
            Text('Silakan masuk untuk melanjutkan',
                textAlign: TextAlign.center,
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: regular,
                )),
            const SizedBox(
              height: 32,
            ),
            Text('Email atau No Telepon',
                textAlign: TextAlign.left,
                style: blackTextStyle.copyWith(
                  fontSize: 13,
                  fontWeight: regular,
                )),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14)),
                  contentPadding: const EdgeInsets.all(12),
                  fillColor: greyColor,
                  iconColor: greyColor,
                  hoverColor: greenColor,
                  focusColor: greyColor,
                  prefixIconColor: greyColor,
                  suffixIconColor: greyColor),
            ),
            const SizedBox(
              height: 24,
            ),
            Text('Password',
                textAlign: TextAlign.left,
                style: blackTextStyle.copyWith(
                  fontSize: 13,
                  fontWeight: regular,
                )),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14)),
                  contentPadding: const EdgeInsets.all(12),
                  fillColor: greyColor,
                  iconColor: greyColor,
                  focusColor: greyColor,
                  prefixIconColor: greyColor,
                  suffixIconColor: greyColor),
            ),
            const SizedBox(
              height: 32,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: TextButton(
                onPressed: () async {
                  toDashboard();
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: greenColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(
                  'Masuk',
                  style: whitekTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
