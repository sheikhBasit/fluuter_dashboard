import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluuter_dashboard/data/bar_graph_data.dart';
import 'package:fluuter_dashboard/models/graph_model.dart';
import 'package:fluuter_dashboard/widgets/custom_card.dart';

class BarGraphCard extends StatelessWidget {
  const BarGraphCard({super.key});
  

  @override
  Widget build(BuildContext context) {
  final BarGraphData barGraphData = BarGraphData();
    return GridView.builder(
      itemCount: barGraphData.data.length,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 12,
        childAspectRatio: 5/4,
      ), itemBuilder: (BuildContext context, int index) {
        return CustomCard(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: const EdgeInsets.all(8.0),
              child: Text(
                barGraphData.data[index].label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ),
              SizedBox(
                height: 12,
              ),
              Expanded(
                child: BarChart(
                  BarChartData(
                    barGroups: _chartGroups(
                      points: barGraphData.data[index].graph,
                      color: barGraphData.data[index].color,
                    ),
                    borderData: FlBorderData(
                      border: const  Border(),
                    ),
                    gridData: FlGridData(
                      show: false,
                    ),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                barGraphData.label[value.toInt()],
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      rightTitles:
                      AxisTitles(
                        sideTitles:  SideTitles(
                        showTitles: false,
                      )),
                      topTitles: AxisTitles(
                        sideTitles:  SideTitles(
                        showTitles: false,
                      )),

                      leftTitles: AxisTitles(
                        sideTitles:  SideTitles(
                        showTitles: false,
                      )),

                    ),
                  )
                ) 
                )
            ],
          ),
        );
        },
    );
  }
  
  List<BarChartGroupData> _chartGroups(
    {required List<GraphModel> points, required Color color}

  ) {
    return points.map((point) => 
    BarChartGroupData(x: point.x.toInt(),
    barRods: [
      BarChartRodData(
        toY: point.y,
        width: 12,
        color: color.withOpacity(point.y.toInt() >  4 ? 1 : 0.4),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(3),
          topRight: const Radius.circular(3),
        ),
      ),
    ],
    )
    ).toList();
     }
}