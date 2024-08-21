import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gmf/Models/average_meth.dart';
// import 'package:mobile_gmf/Models/average_temp.dart';
// import 'package:mobile_gmf/Widgets/chart/bar_data.dart';
// import 'package:mobile_gmf/Widgets/chart/bar_data_kelembapan.dart';
import 'package:mobile_gmf/Widgets/chart/bar_data_metana.dart';

class MyBarGraph3 extends StatelessWidget {
  final List<HourlyMethane> dailySummary3;

  const MyBarGraph3({super.key, required this.dailySummary3});

  @override
  Widget build(BuildContext context) {
    // Initialize BarData with the dailySummary
    BarDataMetana myBarData = BarDataMetana();
    myBarData.initializeBarData(dailySummary3);

    return BarChart(
      BarChartData(
        maxY: 3000,
        minY: 0,
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()}',
                  style: TextStyle(color: Colors.black, fontSize: 10),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()}:00',
                  style: TextStyle(color: Colors.black, fontSize: 10),
                );
              },
            ),
          ),
        ),
        barGroups: myBarData.barData,
      ),
    );
  }
}
