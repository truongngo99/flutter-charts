import 'package:flutter_chart_exam/data/respose/covid/covid.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class BarChartStackState extends BaseState {
  final bool isLoading;
  final CovidModel? covidModelVN;
  final CovidModel? covidModelCam;
  BarChartStackState(
      {this.isLoading = false, this.covidModelVN, this.covidModelCam});

  @override
  List<Object?> get props => [isLoading, covidModelVN, covidModelCam];

  @override
  String toString() =>
      'BarChartStackState: $covidModelVN, $covidModelCam ,$isLoading';

  BarChartStackState copyWith(
          {bool? isLoading,
          CovidModel? covidModelVN,
          CovidModel? covidModelCam}) =>
      BarChartStackState(
        isLoading: isLoading ?? this.isLoading,
        covidModelVN: covidModelVN ?? this.covidModelVN,
        covidModelCam: covidModelCam ?? this.covidModelCam,
      );
}
