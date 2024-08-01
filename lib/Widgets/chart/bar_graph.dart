import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gmf/Theme.dart';
import 'package:mobile_gmf/Widgets/chart/bar_data.dart';

class myBarGraph extends StatelessWidget {
  final List weeklySummary; // [sunAmount...]

  const myBarGraph({super.key, required this.weeklySummary});

  @override
  Widget build(BuildContext context) {
    // initialize bar data
    BarData myBarData = BarData(
      sunAmount: weeklySummary[0],
      monAmount: weeklySummary[1],
      tueAmount: weeklySummary[2],
      wedAmount: weeklySummary[3],
      thurAmount: weeklySummary[4],
      friAmount: weeklySummary[5],
      satAmount: weeklySummary[6],
    );

    myBarData.initializeBarData();
    return BarChart(
      BarChartData(
        maxY: 500, 
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
        barGroups: myBarData.barData.map(
          (data) => BarChartGroupData(
            x: data.x, 
            barRods: [
              BarChartRodData(toY: data.y, 
              color: Color.fromRGBO(242, 207, 207, 1), 
              width: 14 ,
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                toY: 500,
                color: greyColor.withOpacity(0.2)
              )),
              ],
            ),
          ).toList(),
        ),
    );
  }
}
