import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gmf/Models/average_meth.dart';

class BarDataMetana {
  final List<BarChartGroupData> barData = [];

  BarDataMetana();

  void initializeBarData(List<HourlyMethane> hourlyMethane) {
    barData.clear();

    for (var hourlyMeth in hourlyMethane) {
      final methane = hourlyMeth.averageMethane;
      print(
          'Adding BarData: hour=${hourlyMeth.hour}, methane=$methane');

      barData.add(
        BarChartGroupData(
          x: hourlyMeth.hour,
          barRods: [
            BarChartRodData(
              toY: methane,
              color: Color.fromRGBO(242, 207, 207, 1),
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
