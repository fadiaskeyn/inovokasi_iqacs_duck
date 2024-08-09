import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gmf/Models/average_amon.dart';

class BarDataAmonia {
  final List<BarChartGroupData> barData = [];

  BarDataAmonia();

  void initializeBarData(List<HourlyAmonia> hourlyAmonia) {
    barData.clear();

    for (var hourlyAmon in hourlyAmonia) {
      final amonia = hourlyAmon.averageAmonia;
      print(
          'Adding BarData: hour=${hourlyAmon.hour}, amonia=$amonia');

      barData.add(
        BarChartGroupData(
          x: hourlyAmon.hour,
          barRods: [
            BarChartRodData(
              toY: amonia,
              color: Color.fromRGBO(247, 215, 187, 1),
              width: 14,
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                toY: 400,
                color: Colors.grey.withOpacity(0.2),
              ),
            ),
          ],
        ),
      );
    }
  }
}
