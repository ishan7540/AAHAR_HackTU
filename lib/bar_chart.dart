import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class NutrientBarChart extends StatelessWidget {
  final List<double> currentValues = [250, 78, 84];
  final List<double> optimalValues = [282, 83, 70];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8), // Space between title and chart
        SizedBox(
          height: 200, // Adjust height as needed
          width: 360, // Adjust width as needed
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: Colors.black,
                width: 3,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceEvenly,
                  maxY: 400,
                  barGroups: _createBarGroups(),
                  barTouchData: BarTouchData(enabled: true),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: "Coolvetica");
                          switch (value.toInt()) {
                            case 1:
                              return Text('Nitrogen', style: style);
                            case 3:
                              return Text('Phosphorus', style: style);
                            case 5:
                              return Text('Potassium', style: style);
                            default:
                              return Container();
                          }
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: "Coolvetica",
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  groupsSpace: 10,
                  gridData: FlGridData(show: false),
                ),
                swapAnimationDuration: Duration(milliseconds: 800),
                swapAnimationCurve: Curves.easeInOut,
              ),
            ),
          ),
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LegendItem(color: Colors.blue, text: 'Current'),
            SizedBox(width: 16),
            LegendItem(color: Colors.green, text: 'Optimal'),
          ],
        ),
      ],
    );
  }

  List<BarChartGroupData> _createBarGroups() {
    return List.generate(3, (index) {
      return BarChartGroupData(
        x: index * 2 + 1,
        barRods: [
          BarChartRodData(
            toY: currentValues[index],
            color: Colors.blue,
            width: 15,
            borderRadius: BorderRadius.circular(4),
          ),
          BarChartRodData(
            toY: optimalValues[index],
            color: Colors.green,
            width: 15,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
        barsSpace: 4,
      );
    });
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontFamily: "Coolvetica"),
        ),
      ],
    );
  }
}
