import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gmf/Models/average_amon.dart';
import 'package:mobile_gmf/Widgets/chart/bar_data_amonia.dart';
// import 'package:mobile_gmf/Widgets/chart/bar_data_karbon.dart';
// import 'package:mobile_gmf/Widgets/chart/bar_data.dart';
// import 'package:mobile_gmf/Widgets/chart/bar_data_kelembapan.dart';

class MyBarGraph4 extends StatelessWidget {
  final List<HourlyAmonia> dailySummary4;

  const MyBarGraph4({super.key, required this.dailySummary4});

  @override
  Widget build(BuildContext context) {
    // Initialize BarData with the dailySummary
    BarDataAmonia myBarData = BarDataAmonia();
    myBarData.initializeBarData(dailySummary4);

    return BarChart(
      BarChartData(
        maxY: 300,
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
