import 'package:admin_shop/domain/repositories/metric_repository.dart';
import 'package:admin_shop/presentation/Bloc/events/metric_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MetricBloc extends Bloc<MetricsEvents, Map> {
  MetricBloc() : super({}) {
    on<GetMetricsEvent>((event, emit) async {
      final data = await MetricRepository.getMetrics();
      emit(data['data']);
    });
  }
}
