import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class Day17 extends StatelessWidget {
  const Day17({super.key});

  @override
  Widget build(BuildContext context) {
    final latest = _assetData.last;
    final total = latest.breakdown.fold<double>(0, (sum, e) => sum + e.amount);
    final formatter = NumberFormat('#,###');

    return Scaffold(
      appBar: AppBar(title: const Text('syncfusion_flutter_charts')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                '総資産: ¥${formatter.format(total)}',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              '資産構成比率',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SfCircularChart(
                legend: const Legend(
                  isVisible: true,
                  position: LegendPosition.top,
                  overflowMode: LegendItemOverflowMode.wrap,
                  textStyle: TextStyle(fontSize: 12),
                ),
                series: <PieSeries<_AssetBreakdown, String>>[
                  PieSeries<_AssetBreakdown, String>(
                    radius: '80%',
                    explode: true,
                    explodeIndex: 0,
                    dataSource: latest.breakdown,
                    xValueMapper: (data, _) => '${data.type}: ¥${formatter.format(data.amount)}',
                    yValueMapper: (data, _) => data.amount,
                    dataLabelMapper: (data, _) => data.type,
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.outside,
                      overflowMode: OverflowMode.shift,
                      textStyle: TextStyle(fontSize: 10),
                      connectorLineSettings: ConnectorLineSettings(type: ConnectorType.curve),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SfCartesianChart(
                title: const ChartTitle(
                  text: '資産推移',
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                legend: const Legend(isVisible: true),
                primaryXAxis: const CategoryAxis(),
                primaryYAxis: const NumericAxis(),
                series: <CartesianSeries>[
                  LineSeries<_TotalAssetData, String>(
                    name: '現金',
                    dataSource: _assetData,
                    xValueMapper: (data, _) => data.date,
                    yValueMapper: (data, _) => data.breakdown.firstWhere((e) => e.type == '現金').amount,
                    markerSettings: const MarkerSettings(isVisible: true),
                    color: Colors.cyan,
                    width: 2.5,
                  ),
                  LineSeries<_TotalAssetData, String>(
                    name: '投資信託',
                    dataSource: _assetData,
                    xValueMapper: (data, _) => data.date,
                    yValueMapper: (data, _) => data.breakdown.firstWhere((e) => e.type == '投資信託').amount,
                    markerSettings: const MarkerSettings(isVisible: true),
                    color: Colors.deepPurple,
                    width: 2.5,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _TotalAssetData {
  _TotalAssetData(this.date, this.breakdown);
  final String date;
  final List<_AssetBreakdown> breakdown;
}

class _AssetBreakdown {
  _AssetBreakdown(this.type, this.amount);
  final String type;
  final double amount;
}

final List<_TotalAssetData> _assetData = [
  _TotalAssetData('1月', [
    _AssetBreakdown('現金', 100000),
    _AssetBreakdown('投資信託', 200000),
  ]),
  _TotalAssetData('2月', [
    _AssetBreakdown('現金', 120000),
    _AssetBreakdown('投資信託', 220000),
  ]),
  _TotalAssetData('3月', [
    _AssetBreakdown('現金', 160000),
    _AssetBreakdown('投資信託', 290000),
  ]),
];
