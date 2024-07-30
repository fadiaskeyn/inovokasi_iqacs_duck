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
      ApiResponse apiResponse =
          await ApiService().fetchGasReadings(dropdownvalue);
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
      body: Container(
        color: whiteColor,
        child: Column(
          children: [
            Container(
              color: greenColor,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/profile_image.png'),
                    radius: 26,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Selamat datang',
                          style: whitekTextStyle.copyWith(fontWeight: light)),
                      Text(
                        'Admin',
                        style: whitekTextStyle.copyWith(fontWeight: regular),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Image.asset('assets/button_settings.png'),
                    iconSize: 52,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => settingsPage()));
                    },
                  ),
                ],
              ),
            ),
            Container(
              color: greenColor,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Kualitas udara',
                      style: whitekTextStyle.copyWith(fontWeight: bold)),
                  Row(
                    children: [
                      Text('Lokasi',
                          style: whitekTextStyle.copyWith(fontWeight: bold)),
                      SizedBox(width: 3),
                      DropdownButton(
                        value: dropdownvalue,
                        dropdownColor: greenColor,
                        style: whitekTextStyle,
                        icon: Icon(Icons.keyboard_arrow_down,
                            color: Colors.white),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                            print(dropdownvalue);
                            fetchGasReadings();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(20),
                children: [
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: greyColor, width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/iconamonia.png',
                                  height: 40, width: 40),
                              SizedBox(width: 14),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Suhu',
                                      style: blackTextStyle.copyWith(
                                          fontWeight: regular)),
                                  Row(
                                    children: [
                                      Text('$temperature',
                                          style: blackTextStyle.copyWith(
                                              fontSize: 33, fontWeight: bold)),
                                      Text('C',
                                          style: blackTextStyle.copyWith(
                                              fontSize: 14, fontWeight: light)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text('Diperbarui $lastUpdated',
                              style:
                                  blackTextStyle.copyWith(fontWeight: light)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 0.2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                color: pinkColor.withOpacity(0.2), width: 1),
                          ),
                          color: pinkColor.withOpacity(0.2),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Image.asset('assets/iconamonia.png',
                                    height: 40, width: 40),
                                SizedBox(height: 14),
                                Text('Metana',
                                    style: blackTextStyle.copyWith(
                                        fontWeight: regular)),
                                Text('$metana',
                                    style: blackTextStyle.copyWith(
                                        fontWeight: bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                color: greenColor.withOpacity(0.25), width: 1),
                          ),
                          color: greenColor.withOpacity(0.25),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Image.asset('assets/iconamonia.png',
                                    height: 40, width: 40),
                                SizedBox(height: 14),
                                Text('Amonia',
                                    style: blackTextStyle.copyWith(
                                        fontWeight: regular)),
                                Text('$amonia',
                                    style: blackTextStyle.copyWith(
                                        fontWeight: bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                color: greenColor.withOpacity(0.25), width: 1),
                          ),
                          color: greenColor.withOpacity(0.25),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Image.asset('assets/iconamonia.png',
                                    height: 40, width: 40),
                                SizedBox(height: 14),
                                Text('Dioksida',
                                    style: blackTextStyle.copyWith(
                                        fontWeight: regular)),
                                Text('$dioksida',
                                    style: blackTextStyle.copyWith(
                                        fontWeight: bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                                color: blueColor.withOpacity(0.25), width: 1),
                          ),
                          color: blueColor.withOpacity(0.25),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Image.asset('assets/iconamonia.png',
                                    height: 40, width: 40),
                                SizedBox(height: 14),
                                Text('Kelembapan',
                                    style: blackTextStyle.copyWith(
                                        fontWeight: regular)),
                                Text('$humidity',
                                    style: blackTextStyle.copyWith(
                                        fontWeight: bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
