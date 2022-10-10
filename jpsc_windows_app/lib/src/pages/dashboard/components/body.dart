import 'package:fluent_ui/fluent_ui.dart';
import 'package:jpsc_windows_app/src/utils/responsive.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({super.key});

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: const PageHeader(
        title: Text("Dashboard Page"),
      ),
      children: [
        SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          // Chart title
          title: ChartTitle(text: 'Half yearly sales analysis'),
          // Enable legend
          legend: Legend(isVisible: true),
          // Enable tooltip
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <ChartSeries<_SalesData, String>>[
            LineSeries<_SalesData, String>(
                dataSource: data,
                xValueMapper: (_SalesData sales, _) => sales.year,
                yValueMapper: (_SalesData sales, _) => sales.sales,
                name: 'Sales',
                // Enable data label
                dataLabelSettings: const DataLabelSettings(isVisible: true))
          ],
        ),
        Flex(
          direction:
              Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
          children: [
            SfCircularChart(
              title: ChartTitle(
                text: 'Half yearly sales analysis',
                // backgroundColor: Colors.lightGreen,
                borderColor: Colors.blue,
                borderWidth: 2,
                // Aligns the chart title to left
                alignment: ChartAlignment.near,
                textStyle: TextStyle(
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
                      ChartData('Jan', 35),
                      ChartData('Feb', 28),
                      ChartData('Mar', 34),
                      ChartData('Apr', 32),
                      ChartData('May', 40)
                    ],
                    pointColorMapper: (ChartData data, _) => data.color,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    dataLabelSettings: const DataLabelSettings(isVisible: true))
              ],
            ),
            SfCircularChart(
              title: ChartTitle(
                text: 'Half yearly sales analysis',
                // backgroundColor: Colors.lightGreen,
                borderColor: Colors.blue,
                borderWidth: 2,
                // Aligns the chart title to left
                alignment: ChartAlignment.near,
                textStyle: TextStyle(
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
                      ChartData('Jan', 35),
                      ChartData('Feb', 28),
                      ChartData('Mar', 34),
                      ChartData('Apr', 32),
                      ChartData('May', 40)
                    ],
                    pointColorMapper: (ChartData data, _) => data.color,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    dataLabelSettings: const DataLabelSettings(isVisible: true))
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
