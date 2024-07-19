import 'package:flutter/material.dart';
import 'package:mobile_gmf/Models/gas_model.dart';
import 'package:mobile_gmf/Models/api_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<GasData> futureGasData;

  @override
  void initState() {
    super.initState();
    // futureGasData = ApiService().fetchGasData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pemantauan Gas Berbahaya'),
      ),
      body: Center(
        child: FutureBuilder<GasData>(
          future: futureGasData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Ammonia: ${snapshot.data!.ammonia} ppm'),
                  Text('Methane: ${snapshot.data!.methane} ppm'),
                  Text('Carbon Dioxide: ${snapshot.data!.carbonDioxide} ppm'),
                  Text('Nitrous Oxide: ${snapshot.data!.nitrousOxide} ppm'),
                ],
              );
            } else {
              return Text('No data available');
            }
          },
        ),
      ),
    );
  }
}
