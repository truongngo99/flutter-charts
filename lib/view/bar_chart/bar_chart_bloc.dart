import 'package:flutter_chart_exam/data/post/api.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_event.dart';
import 'package:flutter_chart_exam/view/bar_chart/bar_chart_state.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class BarChartBloc extends BaseBloc<BarChartState> {
  Api api;
  BarChartBloc(this.api) : super(BarChartState());

  @override
  Stream<BarChartState> mapEventToState(BaseEvent event) async* {
    if (event is BarChartEvent) {
      yield state.copyWith(isLoading: true);
      var result = await api.getDataCovid();

      yield state.copyWith(isLoading: false, covidModel: result);
    }
  }
}
