import 'package:flutter_chart_exam/data/respose/covid/covid.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class PageViewState extends BaseState {
  final bool isLoading;
  final CovidModel? covidModel;

  PageViewState({this.isLoading = false, this.covidModel});

  @override
  List<Object?> get props => [isLoading, covidModel];
  @override
  String toString() => ' PageView: $isLoading, $covidModel';

  PageViewState copyWith({bool? isLoading, CovidModel? covidModel}) =>
      PageViewState(
        isLoading: isLoading ?? this.isLoading,
        covidModel: covidModel ?? this.covidModel,
      );
}
