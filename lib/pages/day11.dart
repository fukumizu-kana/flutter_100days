import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Day11 extends StatelessWidget {
  const Day11({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'fl_chart',
          style: TextStyle(
            fontFamily: 'ZenMaruGothic',
            fontWeight: FontWeight.bold,
            color: Color(0xFFCE7DA5),
          ),
        ),
        backgroundColor: const Color(0xFFFFF0F7),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFFCE7DA5)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                '円グラフ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFCE7DA5),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 4,
                    centerSpaceRadius: 40,
                    sections: [
                      PieChartSectionData(
                        value: 30,
                        color: Colors.pinkAccent,
                        title: '30%',
                        radius: 60,
                        titleStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      PieChartSectionData(
                        value: 25,
                        color: Colors.orangeAccent,
                        title: '25%',
                        radius: 60,
                        titleStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      PieChartSectionData(
                        value: 20,
                        color: Colors.lightBlueAccent,
                        title: '20%',
                        radius: 60,
                        titleStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      PieChartSectionData(
                        value: 25,
                        color: Colors.greenAccent,
                        title: '25%',
                        radius: 60,
                        titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                '棒グラフ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFCE7DA5)),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 10,
                    barTouchData: BarTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 38,
                          getTitlesWidget: (value, meta) {
                            const style = TextStyle(
                              color: Color(0xFFCE7DA5),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            );
                            switch (value.toInt()) {
                              case 0:
                                return const Text('A', style: style);
                              case 1:
                                return const Text('B', style: style);
                              case 2:
                                return const Text('C', style: style);
                              case 3:
                                return const Text('D', style: style);
                              default:
                                return const SizedBox();
                            }
                          },
                        ),
                      ),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: [
                      BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 9, color: Colors.pinkAccent, width: 30, borderRadius: BorderRadius.zero)]),
                      BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 5, color: Colors.orangeAccent, width: 30, borderRadius: BorderRadius.zero)]),
                      BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 7, color: Colors.lightBlueAccent, width: 30, borderRadius: BorderRadius.zero)]),
                      BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 6, color: Colors.greenAccent, width: 30, borderRadius: BorderRadius.zero)]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
