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
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
    Timer.periodic(Duration(minutes: 1), (Timer timer) {
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/profile_image.png'),
                    radius: 26,
                  ),
                  const SizedBox(width: 20),
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
                  const SizedBox(width: 80),
                  IconButton(
                    icon: Image.asset('assets/button_settings.png'),
                    iconSize: 30,
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Kualitas udara',
                      style: whitekTextStyle.copyWith(fontWeight: bold)),
                  Row(
                    children: [
                      const SizedBox(width: 140),
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
                  RefreshIndicator(
                    onRefresh: fetchData,
                    child: SingleChildScrollView(
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
                                padding: const EdgeInsets.all(10.0),
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
                                                // Image.asset(
                                                //     'assets/iconamonia.png',
                                                //     height: 60,
                                                //     width: 60),
                                                Container(
                                                  height: 110,
                                                  width: 110,
                                                  child: 
                                                    SfRadialGauge(
                                                        axes: <RadialAxis>[
                                                          RadialAxis(
                                                              minimum: 0,
                                                              maximum: 100,
                                                              showLabels: false, 
                                                              showAxisLine: true,
                                                              showLastLabel: true,
                                                              ranges: <GaugeRange>[
                                                                GaugeRange(startValue: 0, endValue: 33, color: Colors.green),
                                                                GaugeRange(startValue: 33, endValue: 66, color: Colors.orange),
                                                                GaugeRange(startValue: 66, endValue: 100, color: Colors.red)
                                                              ],
                                                              pointers: <GaugePointer>[
                                                                NeedlePointer(value: temperature)],
                                                              annotations: <GaugeAnnotation>[
                                                                GaugeAnnotation(
                                                                    widget: Container(
                                                                        child: Text(
                                                                            '',
                                                                            style: TextStyle(
                                                                                fontSize:
                                                                                    15,
                                                                                fontWeight: FontWeight
                                                                                    .w200))),
                                                                    angle: 90,
                                                                    positionFactor:
                                                                        0.5)
                                                              ])
                                                        ])
                                                  
                                                )
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
                                  Color.fromRGBO(197, 237, 203, 1),
                                ),
                                buildGasCard4(
                                  'Metana',
                                  'CH4',
                                  metana,
                                  Color.fromRGBO(242, 207, 207, 1),
                                ),
                                buildGasCard(
                                  'Amonia',
                                  'NH3',
                                  amonia,
                                  Color.fromRGBO(247, 215, 187, 1),
                                ),
                                buildGasCard3(
                                  'Karbon\nDioksida',
                                  'CO2',
                                  dioksida,
                                  Color.fromRGBO(198, 225, 225, 1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
      String title, String kode, double value, Color color) {
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
            Container(
                height: 75,
                width: 70,
                child: SfRadialGauge(axes: <RadialAxis>[
                  RadialAxis(minimum: 0, maximum: 300, showLabels: false, showAxisLine: true,ranges: <GaugeRange>[
                    GaugeRange(
                        startValue: 0, endValue: 30, color: Colors.green),
                    GaugeRange(
                        startValue: 30, endValue: 150, color: Colors.orange),
                    GaugeRange(startValue: 150, endValue: 300, color: Colors.red)
                  ], pointers: <GaugePointer>[
                    NeedlePointer(value: amonia)
                  ], annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        widget: Container(
                            child: Text('',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200))),
                        angle: 90,
                        positionFactor: 0.5)
                  ])
                ])),
            SizedBox(height: 5),
            Row(
              children: [
                const SizedBox(
                  width: 40,
                ),
                Text('$value',
                    style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 16)),
                const SizedBox(
                  width: 5,
                ),
                Text('ppm', style: blackTextStyle.copyWith(fontWeight: light, fontSize: 16)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildGasCard2(
      String title, String kode, double value, Color color) {
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
            Container(
                height: 75,
                width: 70,
                child: SfRadialGauge(axes: <RadialAxis>[
                  RadialAxis(minimum: 0, maximum: 100, showLabels: false, showAxisLine: true, ranges: <GaugeRange>[
                    GaugeRange(
                        startValue: 0, endValue: 33, color: Colors.green),
                    GaugeRange(
                        startValue: 33, endValue: 66, color: Colors.orange),
                    GaugeRange(startValue: 66, endValue: 100, color: Colors.red)
                  ], pointers: <GaugePointer>[
                    NeedlePointer(value: humidity)
                  ], annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        widget: Container(
                            child: Text('',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200))),
                        angle: 90,
                        positionFactor: 0.5)
                  ])
                ])),
            SizedBox(height: 5),
            Row(
              children: [
                const SizedBox(
                  width: 44,
                ),
                Text('$value',
                    style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 16)),
                const SizedBox(
                  width: 5,
                ),
                Text('%', style: blackTextStyle.copyWith(fontWeight: light, fontSize: 16)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildGasCard3(
      String title, String kode, double value, Color color) {
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
            SizedBox(height: 0),
           Container(
                height: 75,
                width: 70,
                child: SfRadialGauge(axes: <RadialAxis>[
                  RadialAxis(
                      minimum: 0,
                      maximum: 9000,
                      showLabels: false,
                      showAxisLine: true,
                      ranges: <GaugeRange>[
                        GaugeRange(
                            startValue: 0, endValue: 5000, color: Colors.green),
                        GaugeRange(
                            startValue: 5000,
                            endValue: 7000,
                            color: Colors.orange),
                        GaugeRange(
                            startValue: 7000, endValue: 9000, color: Colors.red)
                      ],
                      pointers: <GaugePointer>[
                        NeedlePointer(value: dioksida)
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                            widget: Container(
                                child: Text('',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w200))),
                            angle: 90,
                            positionFactor: 0.5)
                      ])
                ])),
            SizedBox(height: 0),
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                Text('$value',
                    style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 16)),
                const SizedBox(
                  width: 5,
                ),
                Text('ppm', style: blackTextStyle.copyWith(fontWeight: light, fontSize: 16)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildGasCard4(
      String title, String kode, double value, Color color) {
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
            Container(
                height: 75,
                width: 70,
                child: SfRadialGauge(axes: <RadialAxis>[
                  RadialAxis(
                      minimum: 0,
                      maximum: 3000,
                      showLabels: false,
                      showAxisLine: true,
                      ranges: <GaugeRange>[
                        GaugeRange(
                            startValue: 0, endValue: 1000, color: Colors.green),
                        GaugeRange(
                            startValue: 1000, endValue: 2000, color: Colors.orange),
                        GaugeRange(
                            startValue: 2000, endValue: 3000, color: Colors.red)
                      ],
                      pointers: <GaugePointer>[
                        NeedlePointer(value: metana)
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                            widget: Container(
                                child: Text('',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w200))),
                            angle: 90,
                            positionFactor: 0.5)
                      ])
                ])),
            SizedBox(height: 5),
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                Text('$value',
                    style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 16)),
                const SizedBox(
                  width: 5,
                ),
                Text('ppm', style: blackTextStyle.copyWith(fontWeight: light, fontSize: 16)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
