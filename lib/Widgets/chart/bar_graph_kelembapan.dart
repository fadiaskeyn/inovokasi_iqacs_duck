import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gmf/Models/average_hum.dart';
// import 'package:mobile_gmf/Widgets/chart/bar_data.dart';
import 'package:mobile_gmf/Widgets/chart/bar_data_kelembapan.dart';

class MyBarGraph2 extends StatelessWidget {
  final List<HourlyHumidity> dailySummary2;

  const MyBarGraph2({super.key, required this.dailySummary2});

  @override
  Widget build(BuildContext context) {
    // Initialize BarData with the dailySummary
    BarDataKelembapan myBarData = BarDataKelembapan();
    myBarData.initializeBarData(dailySummary2);

    return BarChart(
      BarChartData(
        maxY: 100,
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
