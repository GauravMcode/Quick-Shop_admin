import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class AboutMilestone extends StatelessWidget {
  const AboutMilestone({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white.withOpacity(0.0),
      elevation: 30,
      actionsAlignment: MainAxisAlignment.center,
      actions: [ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('  OK  ', style: TextStyle(fontWeight: FontWeight.bold)))],
      content: SizedBox(
        height: 250,
        width: 300,
        child: Card(
          color: Colors.black.withOpacity(0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text('Milestones for sellers :'),
                const SizedBox(height: 30),
                const Text('Sales reached 1k : '),
                Text('"Grand Seller"', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('Sales reached 100k : '),
                Text('"Pro Seller"', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text('Sales reached  1M : '),
                Text('"Legend Seller"', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShowMilestone extends StatelessWidget {
  const ShowMilestone({super.key, required this.state});
  final Map state;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return const AboutMilestone();
            });
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          elevation: 30,
          color: Colors.white.withOpacity(0.4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text.rich(
              TextSpan(children: [
                const TextSpan(text: 'Your Milestone : '),
                TextSpan(text: '"${state['milestone']} Seller"', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
              ]),
              style: TextStyle(color: Theme.of(context).primaryColorDark),
            ),
          ),
        ),
      ),
    );
  }
}

class DataChart extends StatelessWidget {
  const DataChart({
    super.key,
    required this.tooltipBehavior1,
    required this.tooltipBehavior2,
    required this.dataList,
    required this.type,
  });

  final TooltipBehavior tooltipBehavior1;
  final TooltipBehavior tooltipBehavior2;
  final List<MetricData> dataList;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SfCartesianChart(
        title: ChartTitle(text: 'Category wise $type of products : ', textStyle: TextStyle(color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold)),
        legend: Legend(isVisible: true, textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        tooltipBehavior: tooltipBehavior1,
        series: <ChartSeries>[
          BarSeries<MetricData, String>(
            name: type,
            dataSource: dataList,
            xValueMapper: (MetricData data, _) => data.category,
            yValueMapper: (MetricData data, _) => data.data,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            enableTooltip: true,
          ),
        ],
        primaryXAxis: CategoryAxis(labelStyle: TextStyle(color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold)),
        primaryYAxis: NumericAxis(
          labelStyle: TextStyle(color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold),
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          title: AxisTitle(text: '<--- $type --->', textStyle: TextStyle(color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold)),
          numberFormat: type == 'Revenue' ? NumberFormat.simpleCurrency(name: 'INR', decimalDigits: 0) : null,
        ),
      ),
      const SizedBox(height: 20),
      SfCircularChart(
        legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap, textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        tooltipBehavior: tooltipBehavior2,
        series: <PieSeries>[
          PieSeries<MetricData, String>(
            explode: true,
            name: type,
            dataSource: dataList,
            xValueMapper: (MetricData data, _) => data.category,
            yValueMapper: (MetricData data, _) => data.data,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            enableTooltip: true,
          ),
        ],
      ),
    ]);
  }
}

class MetricData {
  String category;
  int data;
  MetricData(this.category, this.data);
}
