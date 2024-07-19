import 'package:flutter/material.dart';
import 'package:mobile_gmf/Screens/Settings_page.dart';
import 'package:mobile_gmf/Theme.dart';
import 'package:mobile_gmf/services/api_services.dart';
import 'package:mobile_gmf/Models/gas_reading.dart';
import 'dart:async';
import 'dart:convert';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future<void> settings() async {
    Navigator.pushNamedAndRemoveUntil(context, '/settings', (route) => false);
  }

  double ammonia = 1.0;
  double methane = 1.0;
  double co2 = 1.0;
  double n20 = 1.0;

  Future<void> toPantau() async {
    Navigator.pushNamedAndRemoveUntil(context, '/pantau', (route) => false);
  }

  @override
  void initState() {
    super.initState();
    runfetchGasReadings();

    // Schedule fetching data every 10 minutes
    Timer.periodic(Duration(minutes: 10), (Timer timer) {
      rerunfetchGasReadings();
    });
  }

  Future<void> rerunfetchGasReadings() async {
    fetchGasReadings();
    runfetchGasReadings();
  }

  Future<void> runfetchGasReadings() async {
    fetchGasReadings();
  }

  Future<void> fetchGasReadings() async {
    try {
      List<GasReading> readings = await ApiService().fetchGasReadings();
      if (readings.isNotEmpty) {
        setState(() {
          ammonia = readings.last.ammonia;
          methane = readings.last.methane;
          co2 = readings.last.carbonDioxide;
          n20 = readings.last.nitrousOxide;
        });
      }
    } catch (e) {
      print('Failed to fetch gas readings: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor,
        elevation: 0,
        toolbarHeight: 20,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: whiteColor,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    // margin: EdgeInsets.only(bottom: 20.0),
                    alignment: Alignment.topCenter,
                    height: 200.0,
                    decoration: BoxDecoration(color: greenColor),
                  ),
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
                        width: 105,
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
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new settingsPage()));
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
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                      //color: Colors.white,
                      width: 400.0,
                      padding: EdgeInsets.only(
                          top: 100, left: 0, right: 0, bottom: 500),
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(20),
                        height: 164,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: greyColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: whiteColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  '0.3',
                                  style: blackTextStyle.copyWith(
                                      fontWeight: bold, fontSize: 28),
                                ),
                                Column(
                                  children: [
                                    const SizedBox(
                                      width: 200,
                                    ),
                                    Text(
                                      'Normal',
                                      style: greenTextStyle.copyWith(
                                          fontSize: 28, fontWeight: bold),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const SizedBox(
                                          height: 50,
                                        ),
                                        Text('Diperbarui 10:00, 26 Juni 2024')
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      )),
                  //start methane and n20 section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 169.0,
                        padding: EdgeInsets.only(
                            top: 290, left: 0, right: 0, bottom: 500),
                        child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.all(10),
                            height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: pinkColor.withOpacity(0.25),
                              ),
                              borderRadius: BorderRadius.circular(10),
                              color: pinkColor.withOpacity(0.25),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Gas Metana',
                                      style: blackTextStyle.copyWith(
                                          fontWeight: regular),
                                    ),
                                    const SizedBox(
                                      width: 18,
                                    ),
                                    Text(
                                      'CH4',
                                      style: blackTextStyle.copyWith(
                                          fontWeight: bold),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/iconmetana.png')),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 14,
                                    ),
                                    Text(
                                      '$methane',
                                      style: blackTextStyle.copyWith(
                                          fontSize: 33, fontWeight: bold),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'ppm',
                                      style: blackTextStyle.copyWith(
                                          fontSize: 14, fontWeight: light),
                                    )
                                  ],
                                )
                              ],
                            )),
                      ),
                      Container(
                          width: 169.0,
                          padding: EdgeInsets.only(
                              top: 290, left: 0, right: 0, bottom: 500),
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.all(10),
                            height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: lightgreenColor.withOpacity(0.25),
                              ),
                              borderRadius: BorderRadius.circular(10),
                              color: lightgreenColor.withOpacity(0.25),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Dinitrogen\nOksida',
                                      style: blackTextStyle.copyWith(
                                          fontWeight: regular),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      'N2O',
                                      style: blackTextStyle.copyWith(
                                          fontWeight: bold),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 14,
                                    ),
                                    Text(
                                      '$n20',
                                      style: blackTextStyle.copyWith(
                                          fontSize: 33, fontWeight: bold),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'ppm',
                                      style: blackTextStyle.copyWith(
                                          fontSize: 14, fontWeight: light),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                    ],
                  ),

                  //end of methane and n20 section

                  //start co2 and nh3 section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 169.0,
                          padding: EdgeInsets.only(
                              top: 440, left: 0, right: 0, bottom: 500),
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.all(10),
                            height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: lightblueColor.withOpacity(0.25),
                              ),
                              borderRadius: BorderRadius.circular(10),
                              color: lightblueColor.withOpacity(0.25),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Karbon\nDioksida',
                                      style: blackTextStyle.copyWith(
                                          fontWeight: regular),
                                    ),
                                    const SizedBox(
                                      width: 42,
                                    ),
                                    Text(
                                      'CO2',
                                      style: blackTextStyle.copyWith(
                                          fontWeight: bold),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 14,
                                    ),
                                    Text(
                                      '$co2',
                                      style: blackTextStyle.copyWith(
                                          fontSize: 33, fontWeight: bold),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'ppm',
                                      style: blackTextStyle.copyWith(
                                          fontSize: 14, fontWeight: light),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                      Container(
                          width: 169.0,
                          padding: EdgeInsets.only(
                              top: 440, left: 0, right: 0, bottom: 500),
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.all(10),
                            height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: softorangeColor.withOpacity(0.25),
                              ),
                              borderRadius: BorderRadius.circular(10),
                              color: softorangeColor.withOpacity(0.25),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Gas Amonia',
                                      style: blackTextStyle.copyWith(
                                          fontWeight: regular),
                                    ),
                                    const SizedBox(
                                      width: 18,
                                    ),
                                    Text(
                                      'NH3',
                                      style: blackTextStyle.copyWith(
                                          fontWeight: bold),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/iconamonia.png')),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 14,
                                    ),
                                    Text(
                                      '$ammonia',
                                      style: blackTextStyle.copyWith(
                                          fontSize: 33, fontWeight: bold),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'ppm',
                                      style: blackTextStyle.copyWith(
                                          fontSize: 14, fontWeight: light),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                  //end co2 and nh3 section
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
