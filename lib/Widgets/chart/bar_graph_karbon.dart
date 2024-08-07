import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gmf/Models/average_temp.dart';
import 'package:mobile_gmf/Widgets/chart/bar_data_karbon.dart';
// import 'package:mobile_gmf/Widgets/chart/bar_data.dart';
// import 'package:mobile_gmf/Widgets/chart/bar_data_kelembapan.dart';

class MyBarGraph5 extends StatelessWidget {
  final List<HourlyTemperature> dailySummary;

  const MyBarGraph5({super.key, required this.dailySummary});

  @override
  Widget build(BuildContext context) {
    // Initialize BarData with the dailySummary
    BarDataKarbon myBarData = BarDataKarbon();
    myBarData.initializeBarData(dailySummary);

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
