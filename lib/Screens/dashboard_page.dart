import 'package:flutter/material.dart';
import 'package:mobile_gmf/Screens/Settings_page.dart';
import 'package:mobile_gmf/Theme.dart';
import 'package:mobile_gmf/services/api_services.dart';
import 'package:mobile_gmf/Models/gas_reading.dart';
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  double dioksida = 0.0;
  double humidity = 0.0;
  double temperature = 0.0;
  double metana = 0.0;
  double amonia = 0.0;
  String lastUpdated = '';

  @override
  void initState() {
    super.initState();
    runfetchGasReadings();

    // Schedule fetching data every 2 minutes
    Timer.periodic(Duration(minutes: 2), (Timer timer) {
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
      ApiResponse apiResponse = await ApiService().fetchGasReadings();
      setState(() {
        dioksida = apiResponse.dioksida.isNotEmpty
            ? apiResponse.dioksida.last.nilai
            : 0.0;
        humidity = apiResponse.humidity.isNotEmpty
            ? apiResponse.humidity.last.nilai
            : 0.0;
        temperature = apiResponse.temperature.isNotEmpty
            ? apiResponse.temperature.last.nilai
            : 0.0;
        metana =
            apiResponse.metana.isNotEmpty ? apiResponse.metana.last.nilai : 0.0;
        amonia =
            apiResponse.amonia.isNotEmpty ? apiResponse.amonia.last.nilai : 0.0;
        lastUpdated = DateFormat('HH:mm, dd MMMM yyyy').format(DateTime.now());
      });
    } catch (e) {
      print('Failed to fetch gas readings: $e');
    }
  }

  // Initial Selected Value
  String dropdownvalue = '1';

  // List of items in our dropdown menu
  var items = [
    '1',
    '2',
    '3',
    '4',
  ];

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
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/button_settings.png'))),
                        child: InkWell(onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => settingsPage()));
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
                            height: 60,
                          ),
                          Row(
                            children: [
                              Text(
                                'Kualitas udara',
                                style:
                                    whitekTextStyle.copyWith(fontWeight: bold),
                              ),
                              const SizedBox(
                                width: 147,
                              ),
                              Text(
                                'Lokasi',
                                style:
                                    whitekTextStyle.copyWith(fontWeight: bold),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              DropdownButton(
                                // Initial Value
                                value: dropdownvalue,
                                focusColor: whiteColor,
                                dropdownColor: greenColor,
                                style: whitekTextStyle,
                                // Down Arrow Icon
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                ),

                                // Array list of items
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!;
                                    print(dropdownvalue);
                                  });
                                },
                              ),
                            ],
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
                                '0',
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
                                      Text('Diperbarui $lastUpdated')
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
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
                                      '$metana',
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
                                      'Ammonia',
                                      style: blackTextStyle.copyWith(
                                          fontWeight: regular),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      'NH3',
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
                                      '$amonia',
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
                                      '$dioksida',
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
                                      'Kelembapan',
                                      style: blackTextStyle.copyWith(
                                          fontWeight: regular),
                                    ),
                                    const SizedBox(
                                      width: 18,
                                    ),
                                    Text(
                                      'HR',
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
                                      '$humidity',
                                      style: blackTextStyle.copyWith(
                                          fontSize: 33, fontWeight: bold),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '%',
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
                  //start temperature section
                  Container(
                      width: 169.0,
                      padding: EdgeInsets.only(
                          top: 590, left: 10, right: 0, bottom: 500),
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
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
                                  'Suhu',
                                  style: blackTextStyle.copyWith(
                                      fontWeight: regular),
                                ),
                                const SizedBox(
                                  width: 18,
                                ),
                                Text(
                                  '',
                                  style:
                                      blackTextStyle.copyWith(fontWeight: bold),
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
                                    image: AssetImage('assets/iconamonia.png')),
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
                                  '$temperature',
                                  style: blackTextStyle.copyWith(
                                      fontSize: 33, fontWeight: bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'C',
                                  style: blackTextStyle.copyWith(
                                      fontSize: 14, fontWeight: light),
                                )
                              ],
                            )
                          ],
                        ),
                      )),
                  //end temperature section
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
