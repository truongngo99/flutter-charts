import 'package:flutter_chart_exam/data/respose/covid/covid.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class BarChartState extends BaseState {
  final bool isLoading;
  final CovidModel? covidModel;
  BarChartState({this.isLoading = false, this.covidModel});

  @override
  List<Object?> get props => [isLoading, covidModel];

  @override
  String toString() => 'BarChartState: $covidModel, $isLoading';

  BarChartState copyWith({bool? isLoading, CovidModel? covidModel}) =>
      BarChartState(
        isLoading: isLoading ?? this.isLoading,
        covidModel: covidModel ?? this.covidModel,
      );
}
