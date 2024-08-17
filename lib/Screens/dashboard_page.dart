import 'package:flutter/material.dart';
import 'package:mobile_gmf/Models/average_diok.dart';
import 'package:mobile_gmf/Models/average_temp.dart';
import 'package:mobile_gmf/Models/average_hum.dart';
import 'package:mobile_gmf/Models/average_meth.dart';
import 'package:mobile_gmf/Models/average_amon.dart';
import 'package:mobile_gmf/Screens/Settings_page.dart';
import 'package:mobile_gmf/Theme.dart';
import 'package:mobile_gmf/Widgets/chart/bar_graph.dart';
import 'package:mobile_gmf/Widgets/chart/bar_graph_amonia.dart';
import 'package:mobile_gmf/Widgets/chart/bar_graph_karbon.dart';
import 'package:mobile_gmf/Widgets/chart/bar_graph_kelembapan.dart';
import 'package:mobile_gmf/Widgets/chart/bar_graph_metana.dart';
import 'package:mobile_gmf/services/api_services.dart';
import 'package:mobile_gmf/services/api_services_temp.dart';
import 'package:mobile_gmf/services/api_services_hum.dart';
import 'package:mobile_gmf/services/api_services_meth.dart';
import 'package:mobile_gmf/services/api_services_amo.dart';
import 'package:mobile_gmf/services/api_services_diok.dart';
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
  List<HourlyTemperature> dailySummary = [];
  List<HourlyHumidity> dailySummary2 = [];
  List<HourlyMethane> dailySummary3 = [];
  List<HourlyAmonia> dailySummary4 = [];
  List<HourlyDioksida> dailySummary5 = [];

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data initially

    // Schedule fetching data every 2 minutes
    Timer.periodic(Duration(minutes: 2), (Timer timer) {
      fetchData();
    });
  }

  Future<void> toSettingsPage() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => settingsPage()));
  }

  Future<void> fetchData() async {
    await fetchGasReadings();
    await fetchDailyTemperatureSummary();
    await fetchDailyHumiditySummary();
    await fetchDailyMethaneSummary();
    await fetchDailyAmoniaSummary();
    await fetchDailyDioksidaSummary();
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

        // Update lastUpdated to the latest created_at field
        final lastUpdatedDate = [
          if (apiResponse.dioksida.isNotEmpty)
            apiResponse.dioksida.last.createdAt,
          if (apiResponse.humidity.isNotEmpty)
            apiResponse.humidity.last.createdAt,
          if (apiResponse.temperature.isNotEmpty)
            apiResponse.temperature.last.createdAt,
          if (apiResponse.metana.isNotEmpty) apiResponse.metana.last.createdAt,
          if (apiResponse.amonia.isNotEmpty) apiResponse.amonia.last.createdAt,
        ].reduce((a, b) => a.isAfter(b) ? a : b);

        lastUpdated = DateFormat('HH:mm, dd MMMM yyyy').format(lastUpdatedDate);
      });
    } catch (e) {
      print('Failed to fetch gas readings: $e');
    }
  }


  Future<void> fetchDailyTemperatureSummary() async {
    try {
      TemperatureData temperatureData =
          await ApiServiceTemp().fetchDailyTemperatureSummary(dropdownvalue);
      setState(() {
        dailySummary = temperatureData.temperatures;
      });
    } catch (e) {
      print('Failed to fetch daily temperature summary: $e');
    }
  }

  Future<void> fetchDailyHumiditySummary() async {
    try {
      HumidityData humidityData =
          await ApiServiceHum().fetchDailyHumiditySummary(dropdownvalue);
      setState(() {
        dailySummary2 = humidityData.humidity;
      });
    } catch (e) {
      print('Failed to fetch daily humidity summary: $e');
    }
  }

  Future<void> fetchDailyMethaneSummary() async {
    try {
      MethaneData methaneData =
          await ApiServiceMeth().fetchDailyMethaneSummary(dropdownvalue);
      setState(() {
        dailySummary3 = methaneData.methane;
      });
    } catch (e) {
      print('Failed to fetch daily methane summary: $e');
    }
  }

  Future<void> fetchDailyAmoniaSummary() async {
    try {
      AmoniaData amoniaData =
          await ApiServiceAmon().fetchDailyAmoniaSummary(dropdownvalue);
      setState(() {
        dailySummary4 = amoniaData.amonia;
      });
    } catch (e) {
      print('Failed to fetch daily amonia summary: $e');
    }
  }

  Future<void> fetchDailyDioksidaSummary() async {
    try {
      DioksidaData dioksidaData =
          await ApiServiceDiok().fetchDailyDioksidaSummary(dropdownvalue);
      setState(() {
        dailySummary5 = dioksidaData.dioksida;
      });
    } catch (e) {
      print('Failed to fetch daily dioksida summary: $e');
    }
  }

  // Initial Selected Value
  String dropdownvalue = '1';

  // List of items in our dropdown menu
  var items = ['1', '2', '3', '4'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor,
        elevation: 0,
        toolbarHeight: 1,
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
                        'Gumukmas Admin',
                        style: whitekTextStyle.copyWith(fontWeight: regular),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Image.asset('assets/button_settings.png'),
                    iconSize: 52,
                    onPressed: () {
                      toSettingsPage();
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
                            fetchData();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: greyColor, width: 0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: 1),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Suhu',
                                              style: blackTextStyle.copyWith(
                                                  fontWeight: regular)),
                                          Row(
                                            children: [
                                              Text('$temperature',
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontSize: 33,
                                                          fontWeight: bold)),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text('C',
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontSize: 33,
                                                          fontWeight: bold)),
                                              const SizedBox(
                                                width: 80,
                                              ),
                                              Image.asset(
                                                  'assets/iconamonia.png',
                                                  height: 60,
                                                  width: 60),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      Text('Diperbarui $lastUpdated',
                                          style: blackTextStyle.copyWith(
                                              fontWeight: light, fontSize: 10)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              buildGasCard2(
                                'Kelembapan',
                                'HR',
                                humidity,
                                'assets/iconamonia.png',
                                Color.fromRGBO(197, 237, 203, 1),
                              ),
                              buildGasCard(
                                'Metana',
                                'CH4',
                                metana,
                                'assets/iconmetana.png',
                                Color.fromRGBO(242, 207, 207, 1),
                              ),
                              buildGasCard(
                                'Amonia',
                                'NH3',
                                amonia,
                                'assets/iconamonia.png',
                                Color.fromRGBO(247, 215, 187, 1),
                              ),
                              buildGasCard3(
                                'Karbon\nDioksida',
                                'CO2',
                                dioksida,
                                'assets/iconamonia.png',
                                Color.fromRGBO(198, 225, 225, 1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Placeholder for the chart page
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Grafik rata-rata suhu',
                        style: blackTextStyle.copyWith(fontWeight: bold),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: greyColor, width: 0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 20, 1, 6),
                              child: Center(
                                  child: MyBarGraph(
                                dailySummary: dailySummary,
                              )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Grafik rata-rata kelembapan',
                        style: blackTextStyle.copyWith(fontWeight: bold),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: greyColor, width: 0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 20, 1, 6),
                              child: Center(
                                  child: MyBarGraph2(
                                dailySummary2: dailySummary2,
                              )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Grafik rata-rata metana',
                        style: blackTextStyle.copyWith(fontWeight: bold),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: greyColor, width: 0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 20, 1, 6),
                              child: Center(
                                  child: MyBarGraph3(
                                dailySummary3: dailySummary3,
                              )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Grafik rata-rata amonia',
                        style: blackTextStyle.copyWith(fontWeight: bold),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: greyColor, width: 0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 20, 1, 6),
                              child: Center(
                                  child: MyBarGraph4(
                                dailySummary4: dailySummary4,
                              )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Grafik rata-rata karbon dioksida',
                        style: blackTextStyle.copyWith(fontWeight: bold),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: greyColor, width: 0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 20, 1, 6),
                              child: Center(
                                  child: MyBarGraph5(
                                dailySummary5: dailySummary5,
                              )),
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

  Widget buildGasCard(
      String title, String kode, double value, String asset, Color color) {
    return Card(
      elevation: 0.1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: color, width: 0.1),
      ),
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(title,
                    style: blackTextStyle.copyWith(fontWeight: regular)),
                const SizedBox(
                  width: 47,
                ),
                Text(kode, style: blackTextStyle.copyWith(fontWeight: bold)),
              ],
            ),
            SizedBox(height: 10),
            Image.asset(asset, height: 56, width: 56),
            SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                Text('$value',
                    style: blackTextStyle.copyWith(fontWeight: bold)),
                const SizedBox(
                  width: 5,
                ),
                Text('ppm', style: blackTextStyle.copyWith(fontWeight: light)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildGasCard2(
      String title, String kode, double value, String asset, Color color) {
    return Card(
      elevation: 0.1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: color, width: 0.1),
      ),
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(title,
                    style: blackTextStyle.copyWith(fontWeight: regular)),
                const SizedBox(
                  width: 25,
                ),
                Text(kode, style: blackTextStyle.copyWith(fontWeight: bold)),
              ],
            ),
            SizedBox(height: 10),
            Image.asset(asset, height: 56, width: 56),
            SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(
                  width: 44,
                ),
                Text('$value',
                    style: blackTextStyle.copyWith(fontWeight: bold)),
                const SizedBox(
                  width: 5,
                ),
                Text('%', style: blackTextStyle.copyWith(fontWeight: light)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildGasCard3(
      String title, String kode, double value, String asset, Color color) {
    return Card(
      elevation: 0.1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: color, width: 0.1),
      ),
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(title,
                    style: blackTextStyle.copyWith(fontWeight: regular)),
                const SizedBox(
                  width: 40,
                ),
                Text(kode, style: blackTextStyle.copyWith(fontWeight: bold)),
              ],
            ),
            SizedBox(height: 10),
            Image.asset(asset, height: 56, width: 56),
            SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                Text('$value',
                    style: blackTextStyle.copyWith(fontWeight: bold)),
                const SizedBox(
                  width: 5,
                ),
                Text('ppm', style: blackTextStyle.copyWith(fontWeight: light)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
