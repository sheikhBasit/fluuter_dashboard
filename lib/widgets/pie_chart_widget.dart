import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_dashboard/constants/constants.dart';
import 'package:fluuter_dashboard/data/pie_chart_data.dart';

class Chart extends StatelessWidget {
   Chart({super.key});

  final pieChartData = ChartData();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: pieChartData.pieChartSelectionData,
              borderData: FlBorderData(show: false),
              pieTouchData: PieTouchData(enabled: false),
              // uncomment this line to show the chart legend
              // sections: pieChartData.sections,
            ),
          ),
          Positioned.fill(child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: defaultPadding,),
              Text("70%",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                height: 0.5,
              ),),
              const SizedBox(height: 8,),
              const Text("of 100%",)
              
            ],)
          )
          
        ],
      ),
    );
  }
}