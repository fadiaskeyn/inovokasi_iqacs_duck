import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gmf/Models/average_temp.dart';

class BarData {
  final List<BarChartGroupData> barData = [];

  BarData();

  void initializeBarData(List<HourlyTemperature> hourlyTemperatures) {
    barData.clear();

    for (var hourlyTemp in hourlyTemperatures) {
      final temperature = hourlyTemp.averageTemperature;
      print(
          'Adding BarData: hour=${hourlyTemp.hour}, temperature=$temperature');

      barData.add(
        BarChartGroupData(
          x: hourlyTemp.hour,
          barRods: [
            BarChartRodData(
              toY: temperature,
              color: Color.fromRGBO(221, 245, 9, 1),
              width: 14,
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                toY: 100,
                color: Colors.grey.withOpacity(0.2),
              ),
            ),
          ],
        ),
      );
    }
  }
}
