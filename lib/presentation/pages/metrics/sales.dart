import 'package:admin_shop/presentation/Bloc/bloc/metric_bloc.dart';
import 'package:admin_shop/presentation/widgets/metrics/metrics_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class SalesReportPage extends StatefulWidget {
  const SalesReportPage({super.key, required this.isPushed});
  final bool isPushed;

  @override
  State<SalesReportPage> createState() => _SalesReportPageState();
}

class _SalesReportPageState extends State<SalesReportPage> {
  final TooltipBehavior _tooltipBehavior1 = TooltipBehavior(enable: true);
  final TooltipBehavior _tooltipBehavior2 = TooltipBehavior(enable: true);
  final TooltipBehavior _tooltipBehavior3 = TooltipBehavior(enable: true);
  final TooltipBehavior _tooltipBehavior4 = TooltipBehavior(enable: true);
  NumberFormat numberFormat = NumberFormat.decimalPattern('hi');
  List<Color> gradColors = [const Color(0xff2f3542).withOpacity(0.7), const Color(0xffced6e0)];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: widget.isPushed ? AppBar(title: const Text('Sales Report'), centerTitle: true) : const PreferredSize(preferredSize: Size(0, 0), child: SizedBox.shrink()),
        body: BlocBuilder<MetricBloc, Map>(
          builder: (context, state) {
            final List<MetricData> salesList =
                state.isNotEmpty ? List.generate(state['views'].length, (index) => MetricData(state['sales'].keys.elementAt(index), state['sales'].values.elementAt(index))) : [];
            final List<MetricData> revenueList =
                state.isNotEmpty ? List.generate(state['revenue'].length, (index) => MetricData(state['revenue'].keys.elementAt(index), state['revenue'].values.elementAt(index))) : [];
            return SingleChildScrollView(
              child: Column(
                children: [
                  ShowMilestone(state: state),
                  state.isNotEmpty
                      ? Chip(
                          backgroundColor: Colors.green.withOpacity(0.9),
                          label: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text('Total Revenue Earned : ₹ ${numberFormat.format(state['totalRevenue'])}', style: const TextStyle(fontSize: 20, color: Colors.white)),
                          ),
                        )
                      : Lottie.asset('assets/143310-loader.json'),
                  DataChart(tooltipBehavior1: _tooltipBehavior1, tooltipBehavior2: _tooltipBehavior2, dataList: revenueList, type: 'Revenue'),
                  const Divider(thickness: 2),
                  state.isNotEmpty
                      ? Chip(
                          backgroundColor: Colors.black.withOpacity(0.7),
                          label: Text('Total Products Sold : ${state['totalSales']}', style: const TextStyle(fontSize: 20, color: Colors.white)),
                          avatar: const Icon(Icons.show_chart_sharp, color: Colors.white))
                      : Lottie.asset('assets/143310-loader.json'),
                  DataChart(tooltipBehavior1: _tooltipBehavior3, tooltipBehavior2: _tooltipBehavior4, dataList: salesList, type: 'Sales'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
