import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_dashboard/constants/constants.dart';

class ChartData{
  final pieChartSelectionData = [
    PieChartSectionData(
      color: primaryColor,
      value: 25,
      showTitle: false,
      radius: 25

    ),
    PieChartSectionData(
      color: Colors.redAccent,
      value: 25,
      showTitle: false,
      radius: 20
    ),
    PieChartSectionData(
      color: Colors.blueAccent,
      value: 25,
      showTitle: false,
      radius: 19
    ),
    PieChartSectionData(
      color: Colors.greenAccent,
      value: 25,
      showTitle: false,
      radius: 16
    ),
    PieChartSectionData(
      color: primaryColor.withOpacity(0.1),
      value: 25,
      showTitle: false,
      radius: 13
    ),

  ];
}