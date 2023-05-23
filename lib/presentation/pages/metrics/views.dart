import 'package:admin_shop/presentation/Bloc/bloc/metric_bloc.dart';
import 'package:admin_shop/presentation/widgets/metrics/metrics_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MetricsPage extends StatefulWidget {
  const MetricsPage({super.key});

  @override
  State<MetricsPage> createState() => _MetricsPageState();
}

class _MetricsPageState extends State<MetricsPage> {
  final TooltipBehavior _tooltipBehavior1 = TooltipBehavior(enable: true);
  final TooltipBehavior _tooltipBehavior2 = TooltipBehavior(enable: true);
  List<Color> gradColors = [const Color(0xff2f3542).withOpacity(0.7), const Color(0xffced6e0)];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MetricBloc, Map>(
      builder: (context, state) {
        final List<MetricData> dataList =
            state.isNotEmpty ? List.generate(state['views'].length, (index) => MetricData(state['views'].keys.elementAt(index), state['views'].values.elementAt(index))) : [];
        return SingleChildScrollView(
          child: Column(
            children: [
              state.isNotEmpty
                  ? Chip(
                      backgroundColor: Colors.black.withOpacity(0.7),
                      label: Text('Total product views : ${state['totalViews']}', style: const TextStyle(fontSize: 20, color: Colors.white)),
                      avatar: const Icon(Icons.bar_chart, color: Colors.white))
                  : Lottie.asset('assets/143310-loader.json'),
              DataChart(tooltipBehavior1: _tooltipBehavior1, tooltipBehavior2: _tooltipBehavior2, dataList: dataList, type: 'Views'),
            ],
          ),
        );
      },
    );
  }
}
