import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gmf/Models/average_diok.dart';

class BarDataDioksida {
  final List<BarChartGroupData> barData = [];

  BarDataDioksida();

  void initializeBarData(List<HourlyDioksida> hourlyDioksida) {
    barData.clear();

    for (var hourlyDiok in hourlyDioksida) {
      final dioksida = hourlyDiok.averageDioksida;
      print(
          'Adding BarData: hour=${hourlyDiok.hour}, dioksida=$dioksida');

      barData.add(
        BarChartGroupData(
          x: hourlyDiok.hour,
          barRods: [
            BarChartRodData(
              toY: dioksida,
              color: Color.fromRGBO(198, 225, 225, 1),
              width: 14,
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                toY: 9000,
                color: Colors.grey.withOpacity(0.2),
              ),
            ),
          ],
        ),
      );
    }
  }
}
