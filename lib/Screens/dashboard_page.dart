import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  String dropdownvalue = '1';

  var items = ['1', '2', '3', '4'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBrown,
        elevation: 0,
        toolbarHeight: 1,
      ),
      body: Container(
        color: bgcuy,
        child: Column(
          children: [
            Container(
              color: darkBrown,
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
                        'Admin',
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
              decoration: BoxDecoration(
                color: darkBrown,
                image: DecorationImage(
                  image: AssetImage('assets/bgss.png'),
                  fit: BoxFit.cover,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Kualitas udara',
                    style:
                        whitekTextStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // ini antara suhu & header
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bagian kiri untuk gambar
                  Image.asset(
                    "assets/lamp.png",
                    width: 120.0,
                    height: 120.0,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(width: 15), // Spasi antara gambar dan teks

                  // Bagian kanan untuk teks dan switch
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          "Status Lampu",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Mati",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 5),
                        Switch(
                          value: false,
                          onChanged: (bool value) {
                            // Tambahkan logika di sini jika diperlukan
                          },
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),

// End

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
                                side: BorderSide(color: greyColor, width: 1),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: 1),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Gas Amonia',
                                              style: blackTextStyle.copyWith(
                                                  fontWeight: regular),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Image.asset(
                                                  "assets/amonia.png",
                                                  width: 65.0,
                                                  height: 65.0,
                                                  fit: BoxFit.fill,
                                                ),
                                                SizedBox(
                                                    width:
                                                        120), // Memberikan jarak antara gambar dan teks suhu
                                                Text(
                                                  '$temperature',
                                                  style:
                                                      blackTextStyle.copyWith(
                                                    fontSize: 33,
                                                    fontWeight: bold,
                                                  ),
                                                ),
                                                SizedBox(width: 20),
                                                Text(
                                                  'ppm',
                                                  style:
                                                      blackTextStyle.copyWith(
                                                    fontSize: 15,
                                                    fontWeight: bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 4,
                              mainAxisSpacing: 4,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                buildGasKelembapan(
                                  'Kelembapan',
                                  'HR',
                                  amonia,
                                  Color.fromRGBO(255, 255, 255, 1),
                                ),
                                buildGasSuhu(
                                  'Suhu',
                                  'C',
                                  dioksida,
                                  Color.fromRGBO(255, 255, 255, 1),
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

  Widget buildGasKelembapan(
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
                Text(
                  title,
                  style: blackTextStyle.copyWith(fontWeight: FontWeight.w400),
                ),
                const SizedBox(width: 30),
                Text(
                  kode,
                  style: blackTextStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 115,
              width: 115,
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    interval: 20,
                    startAngle: 0,
                    endAngle: 360,
                    showTicks: false,
                    showLabels: false,
                    axisLineStyle: AxisLineStyle(thickness: 20),
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: value,
                        width: 20,
                        color: Color.fromARGB(237, 247, 177, 91),
                        enableAnimation: true,
                        cornerStyle: CornerStyle.bothCurve,
                      ),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                              child: Column(
                                children: [
                                  Text(
                                    '${value.toStringAsFixed(1)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    '%',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        angle: 270,
                        positionFactor: 0.2,
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

  Widget buildGasSuhu(String title, String kode, double value, Color color) {
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
                Text(
                  title,
                  style: blackTextStyle.copyWith(fontWeight: FontWeight.w400),
                ),
                const SizedBox(width: 30),
                Text(
                  kode,
                  style: blackTextStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 115,
              width: 115,
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    interval: 20,
                    startAngle: 0,
                    endAngle: 360,
                    showTicks: false,
                    showLabels: false,
                    axisLineStyle: AxisLineStyle(thickness: 20),
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: value,
                        width: 20,
                        color: Color(0xFFFFCD60),
                        enableAnimation: true,
                        cornerStyle: CornerStyle.bothCurve,
                      ),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                              child: Column(
                                children: [
                                  Text(
                                    '${value.toStringAsFixed(1)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    '°C',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        angle: 270,
                        positionFactor: 0.2,
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

  Widget buildGasCard2(String title, String kode, double value, Color color) {
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
                  RadialAxis(
                      minimum: 0,
                      maximum: 100,
                      showLabels: false,
                      showAxisLine: true,
                      ranges: <GaugeRange>[
                        GaugeRange(
                            startValue: 0, endValue: 33, color: Colors.green),
                        GaugeRange(
                            startValue: 33, endValue: 66, color: Colors.orange),
                        GaugeRange(
                            startValue: 66, endValue: 100, color: Colors.red)
                      ],
                      pointers: <GaugePointer>[
                        NeedlePointer(value: humidity)
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
                  width: 44,
                ),
                Text('$value',
                    style: blackTextStyle.copyWith(
                        fontWeight: bold, fontSize: 16)),
                const SizedBox(
                  width: 5,
                ),
                Text('%',
                    style: blackTextStyle.copyWith(
                        fontWeight: light, fontSize: 16)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildGasCard4(String title, String kode, double value, Color color) {
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
                            startValue: 1000,
                            endValue: 2000,
                            color: Colors.orange),
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
                    style: blackTextStyle.copyWith(
                        fontWeight: bold, fontSize: 16)),
                const SizedBox(
                  width: 5,
                ),
                Text('ppm',
                    style: blackTextStyle.copyWith(
                        fontWeight: light, fontSize: 16)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
