import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_gmf/Screens/dashboard_page.dart';
import 'package:mobile_gmf/Theme.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_gmf/services/api_connect.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> toDashboard() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DashboardPage()));
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: danger99Color,
        content: Row(
          children: [
            Icon(Icons.error_outline, color: danger40Color, size: 50),
            const SizedBox(width: 20),
            Text(
              message,
              style: blackTextStyle.copyWith(fontWeight: medium),
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSnackBarSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: whiteColor,
        content: Row(
          children: [
            Icon(Icons.check, color: greenColor, size: 50),
            const SizedBox(width: 20),
            Text(
              'Berhasil Login',
              style: blackTextStyle.copyWith(fontWeight: medium),
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  login() async {
    try {
      final res = await http.post(Uri.parse(ApiConnect.login), body: {
        "email": emailController.text,
        "password": passwordController.text,
      });
      if (res.statusCode == 200) {
        String datauser = res.body;
        var hasiluser = jsonDecode(datauser);
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();

        var token = hasiluser["token"];
        sharedPreferences.setString('token', token.toString());
        var name = hasiluser["name"];
        sharedPreferences.setString('name', name.toString());
        var email = hasiluser["email"];
        sharedPreferences.setString('email', email.toString());
        setState(() {
          print(hasiluser);
          _showSnackBarSuccess();
          toDashboard();
        });
        // _showSnackBarAndNavigateToLogin();
      } else {
        setState(() {
          _showSnackBar(
              'Login gagal, periksa koneksi dan\ndetail akun lalu coba lagi');
        });
      }

      // if (res.statusCode == 401) {
      //   setState(() {
      //     _showSnackBar('Password Yang Anda Masukkan Salah');
      //   });
      // }
      // if (res.statusCode == 400) {
      //   setState(() {
      //     _showSnackBar('Login gagal, email tidak terdaftar');
      //   });
      // }
    } catch (e) {
      rethrow;
    }
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
                  image: DecorationImage(image: AssetImage('assets/duck.png'))),
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
            Text('Email',
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
              controller: emailController,
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
              controller: passwordController,
              obscuringCharacter: '*',
              obscureText: true,
            ),
            const SizedBox(
              height: 32,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: TextButton(
                onPressed: () async {
                  login();
                  print(emailController.text);
                  print(passwordController.text);
                  // _showSnackBar();
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.brown,
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
