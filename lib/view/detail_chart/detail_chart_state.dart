import 'package:flutter_chart_exam/data/respose/covid/covid.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class DetailChartState extends BaseState {
  final bool isLoading;
  final CovidModel? covidModel;
  DetailChartState({this.isLoading = false, this.covidModel});
  @override
  List<Object?> get props => [isLoading, covidModel];

  @override
  String toString() => 'DetailChartState: $isLoading, $covidModel';

  DetailChartState copyWith({bool? isLoading, CovidModel? covidModel}) =>
      DetailChartState(
        isLoading: isLoading ?? this.isLoading,
        covidModel: covidModel ?? this.covidModel,
      );
}
