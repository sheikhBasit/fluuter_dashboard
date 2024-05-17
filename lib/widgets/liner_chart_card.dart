import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_dashboard/constants/constants.dart';
import 'package:fluuter_dashboard/data/line_chart_data.dart';
import 'package:fluuter_dashboard/widgets/custom_card.dart';

class LinerChartCard extends StatelessWidget {
  const LinerChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    final data = LinerChartData();
    return CustomCard(
      child: Column(
        children: [
          Text('Steps Overview'),
          SizedBox(height: 12,),
          AspectRatio(
            aspectRatio: 16/6, 
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  handleBuiltInTouches: true,
                ),
                gridData: FlGridData(
                  show: false,
                ),
                titlesData: FlTitlesData(
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value,meta){
                        return data.bottomTitle[value.toInt()] != null ? 
                        Text(data.bottomTitle[value.toInt()] as String,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,)
                        ) :
                         const SizedBox();
                      },
                      interval: 1,
                      reservedSize: 40,
                      
                      
                    ),
                  ),

                ),
                borderData: FlBorderData(
                  show: false,
                ),
                lineBarsData: [
                  LineChartBarData(
                    color: selectionColor,
                    barWidth: 2.5,
                    belowBarData: BarAreaData(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [selectionColor.withOpacity(0.5), Colors.transparent],
                      ),
                      show: true,
                    ),
                    dotData: FlDotData(
                      show: false,
                    ),
                    spots: data.spots,
                  ),
                ]
            ))
      ),
      ],
      ),
    );
  }
}