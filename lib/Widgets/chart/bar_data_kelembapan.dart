import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gmf/Models/average_hum.dart';

class BarDataKelembapan {
  final List<BarChartGroupData> barData = [];

  BarDataKelembapan();

  void initializeBarData(List<HourlyHumidity> hourlyHumidity) {
    barData.clear();

    for (var hourlyHum in hourlyHumidity) {
      final humidity = hourlyHum.averageHumidity;
      print(
          'Adding BarData: hour=${hourlyHum.hour}, humidity=$humidity');

      barData.add(
        BarChartGroupData(
          x: hourlyHum.hour,
          barRods: [
            BarChartRodData(
              toY: humidity,
              color: Color.fromRGBO(197, 237, 203, 1),
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
