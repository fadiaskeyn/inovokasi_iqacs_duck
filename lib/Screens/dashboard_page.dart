import 'package:flutter/material.dart';
import 'package:mobile_gmf/Theme.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  login() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            Text('Ini adalah Dashboard',
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
                onPressed: login(),
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
