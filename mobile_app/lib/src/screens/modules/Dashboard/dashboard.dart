import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(text: 'My Half yearly sales analysis'),
            // Enable legend
            legend: Legend(isVisible: true),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<ChartData, String>>[
              LineSeries<ChartData, String>(
                  dataSource: [
                    ChartData('Jan', 35),
                    ChartData('Feb', 28),
                    ChartData('Mar', 34),
                    ChartData('Apr', 32),
                    ChartData('May', 40),
                  ],
                  xValueMapper: (ChartData sales, _) => sales.x,
                  yValueMapper: (ChartData sales, _) => sales.y,
                  name: 'Sales',
                  // Enable data label
                  dataLabelSettings: const DataLabelSettings(isVisible: true))
            ],
          ),
          SfCircularChart(
            title: ChartTitle(
              text: 'Current Month Transactions',
              // backgroundColor: Colors.lightGreen,
              borderColor: Colors.blue,
              borderWidth: 2,
              // Aligns the chart title to left
              alignment: ChartAlignment.near,
              textStyle: const TextStyle(
                color: Colors.red,
                fontFamily: 'Roboto',
                fontStyle: FontStyle.italic,
                fontSize: 14,
              ),
            ),
            legend: Legend(
                isVisible: true, overflowMode: LegendItemOverflowMode.scroll),
            series: <CircularSeries>[
              // Initialize line series
              DoughnutSeries<ChartData, String>(
                  dataSource: [
                    // Bind data source
                    ChartData('Approved', 62),
                    ChartData('Pending', 28),
                    ChartData('Canceled', 10),
                  ],
                  pointColorMapper: (ChartData data, _) => data.color,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  dataLabelSettings: const DataLabelSettings(isVisible: true))
            ],
          ),
          SfCircularChart(
            title: ChartTitle(
              text: 'My Top 5 Customers',
              // backgroundColor: Colors.lightGreen,
              borderColor: Colors.blue,
              borderWidth: 2,
              // Aligns the chart title to left
              alignment: ChartAlignment.near,
              textStyle: const TextStyle(
                color: Colors.red,
                fontFamily: 'Roboto',
                fontStyle: FontStyle.italic,
                fontSize: 14,
              ),
            ),
            legend: Legend(
                isVisible: true, overflowMode: LegendItemOverflowMode.scroll),
            series: <CircularSeries>[
              // Initialize line series
              PieSeries<ChartData, String>(
                  dataSource: [
                    // Bind data source
                    ChartData('Customer 1', 30),
                    ChartData('Customer 2', 25),
                    ChartData('Customer 3', 15),
                    ChartData('Customer 4', 12),
                    ChartData('Customer 5', 13),
                    ChartData('Others', 10),
                  ],
                  pointColorMapper: (ChartData data, _) => data.color,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  dataLabelSettings: const DataLabelSettings(isVisible: true))
            ],
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
