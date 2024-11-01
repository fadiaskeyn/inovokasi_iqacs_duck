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
  bool isLampOn = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBrown,
        elevation: 0,
        toolbarHeight: 20,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              color: Colors.redAccent,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                      Text('Selamat Datang',
                          style: TextStyle(color: Colors.white, fontSize: 12)),
                      Text('Admin Itik',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ],
                  ),
                  // IconButton(
                  //   icon: Icon(Icons.menu, color: Colors.white),
                  //   onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => SettingsPage()));
                  //   },
                  // ),
                ],
              ),
            ),

            // Status Lamp Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.lightbulb_outline,
                              size: 40, color: Colors.grey),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Status Lampu",
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text(isLampOn ? "Nyala" : "Mati",
                                  style: TextStyle(fontSize: 14)),
                            ],
                          ),
                          Spacer(),
                          Switch(
                            value: isLampOn,
                            onChanged: (value) {
                              setState(() {
                                isLampOn = value;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text("Diperbarui $lastUpdated",
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ),

            // Gas and Sensor Data Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  sensorCard("Gas Amonia", "$amonia ppm",
                      "assets/iconamonia.png", Colors.orange),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: sensorCard("Kelembapan", "$humidity%",
                              "assets/iconamonia.png", Colors.blue)),
                      SizedBox(width: 10),
                      Expanded(
                          child: sensorCard("Suhu", "$temperature°C",
                              "assets/iconamonia.png", Colors.red)),
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

  Widget sensorCard(String title, String value, String iconPath, Color color) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Image.asset(iconPath, height: 40, color: color),
            SizedBox(height: 10),
            Text(title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(value,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
