import 'package:flutter/material.dart';
import 'package:mobile_gmf/Theme.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future<void> settings() async {
    Navigator.pushNamedAndRemoveUntil(context, '/settings', (route) => false);
  }

  Future<void> toPantau() async {
    Navigator.pushNamedAndRemoveUntil(context, '/pantau', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: greenColor,
          elevation: 0,
          toolbarHeight: 20,
        ),
        backgroundColor: whiteColor,
        body: Center(
            child: Column(
          children: [
            Container(
              width: 393,
              height: 200,
              color: greenColor,
              child: Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 52,
                        width: 52,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/profile_image.png')),
                            shape: BoxShape.circle),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text('Selamat datang',
                              style:
                                  whitekTextStyle.copyWith(fontWeight: light)),
                          Text(
                            'Admin',
                            style:
                                whitekTextStyle.copyWith(fontWeight: regular),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      Container(
                        height: 52,
                        width: 52,
                        // color: whiteColor,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/button_settings.png'))),
                        child: InkWell(onTap: () {
                          toPantau();
                        }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 80,
                          ),
                          Text(
                            'Kualitas udara saat ini',
                            style: whitekTextStyle.copyWith(fontWeight: bold),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Container(
                            height: 70,
                            width: 320,
                            color: greyColor,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: whiteColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),

            // Container(
            //   height: 100,
            //   width: 320,
            //   color: greyColor,
            //   child: Padding(
            //     padding: const EdgeInsets.all(10),
            //     child: Column(
            //       children: [
            //         Container(
            //           height: 10,
            //           width: 10,
            //           decoration: BoxDecoration(
            //             shape: BoxShape.circle,
            //             color: whiteColor,
            //           ),

            //         )
            //       ],
            //     ),
            //     ),

            // ),
          ],
        )));
  }
}
