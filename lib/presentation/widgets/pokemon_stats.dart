import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/stat.dart';

class PokemonStatsChart extends StatelessWidget {
  final List<Stat> stats;

  const PokemonStatsChart({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350, // Adjust height for better display
      padding: EdgeInsets.all(16),
      child: BarChart(
        BarChartData(
          barGroups: _buildBarGroups(),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, _) {
                  return Text(
                    value.toInt().toString(),
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (index >= 0 && index < stats.length) {
                    return Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        stats[index].statName.toUpperCase(),
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  return Container();
                },
                reservedSize: 40,
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: true),
          maxY: _getMaxY(), // Adjust max Y dynamically
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return List.generate(stats.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: stats[index].value.toDouble(),
            color: Colors.blueAccent,
            width: 16,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });
  }

  double _getMaxY() {
    double maxStat = stats.map((stat) => stat.value).reduce((a, b) => a > b ? a : b).toDouble();
    return (maxStat * 1.2).clamp(100, 200); // Ensure it fits well
  }
}
