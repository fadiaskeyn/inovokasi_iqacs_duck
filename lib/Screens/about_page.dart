import 'package:flutter/material.dart';
import 'package:mobile_gmf/Screens/Settings_page.dart';
import 'package:mobile_gmf/Screens/signIn_page.dart';
import 'package:mobile_gmf/Theme.dart';
import 'package:mobile_gmf/Screens/dashboard_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class aboutPage extends StatefulWidget {
  const aboutPage({super.key});

  @override
  State<aboutPage> createState() => _aboutPageState();
}

class _aboutPageState extends State<aboutPage> {
  logout() {
    setState(() {
      sendLogout();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SignInPage()),
          (route) => false);
    });
  }

  toAccount() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => settingsPage()),
        (route) => false);
  }

  Future<void> sendLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('name');
    prefs.remove('email');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          title: Text('Pengaturan Lainnya',
              style: blackTextStyle.copyWith(
                  fontSize: 16, fontWeight: FontWeight.bold)),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: blackColor,
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: toAccount,
                    child: Container(
                      height: 34,
                      width: 100,
                      // color: greenColor,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: greyColor.withOpacity(0.25),
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: whiteColor,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Akun',
                            style: blackTextStyle.copyWith(fontSize: 11),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 34,
                    width: 100,
                    // color: greenColor,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: greenColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: greenColor,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Tentang Aplikasi',
                          style: whitekTextStyle.copyWith(fontSize: 11),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 340.0,
                child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    height: 165,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: greyColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: whiteColor.withOpacity(0.25),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            'Gumukmas Multifarm (GMF) adalah perusahaan yang berfokus pada kemitraan domba dan penyediaan pakan ternak ruminansia berkualitas tinggi. Berlokasi di Jember, Jawa Timur, kami berkomitmen untuk mendukung peternak lokal menjadi go internasional. Hubungi kami dibawah ini!',
                            style: blackTextStyle.copyWith(
                                fontSize: 13, fontWeight: regular),
                            textAlign: TextAlign.justify,
                          ),
                        )
                        // Column(
                        //   children: [
                        //     const SizedBox(
                        //       height: 10,
                        //     ),
                        //     Text(
                        //       'Gumukmas Multifarm (GMF) adalah perusahaan yang berfokus pada kemitraan domba dan penyediaan pakan ternak ruminansia berkualitas tinggi. Berlokasi di Jember, Jawa Timur, kami berkomitmen untuk mendukung peternak lokal menjadi go internasional. Hubungi kami dibawah ini !',
                        //       style: blackTextStyle.copyWith(
                        //           fontSize: 13, fontWeight: bold),
                        //       textAlign: TextAlign.justify,
                        //     ),
                        //   ],
                        // ),
                      ],
                    )),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                height: 40,
                width: 340,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: greyColor.withOpacity(0.25),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: whiteColor,
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 20,
                      width: 20,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/instagram.png')),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      'gumukmasmultifarm',
                      style: greyTextStyle.copyWith(
                          fontSize: 11, fontWeight: light),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                height: 40,
                width: 340,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: greyColor.withOpacity(0.25),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: whiteColor,
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 20,
                      width: 20,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/facebook.png')),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Gumukmas Multifarm',
                      style: greyTextStyle.copyWith(
                          fontSize: 11, fontWeight: light),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                height: 40,
                width: 340,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: greyColor.withOpacity(0.25),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: whiteColor,
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 20,
                      width: 20,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/twitter.png')),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      'FarmMulti',
                      style: greyTextStyle.copyWith(
                          fontSize: 11, fontWeight: light),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                height: 40,
                width: 340,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: greyColor.withOpacity(0.25),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: whiteColor,
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 20,
                      width: 20,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/youtube.png')),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Gumukmas Multifarm',
                      style: greyTextStyle.copyWith(
                          fontSize: 11, fontWeight: light),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
