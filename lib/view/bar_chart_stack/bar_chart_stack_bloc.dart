import 'package:flutter_chart_exam/data/post/api.dart';
import 'package:flutter_chart_exam/view/bar_chart_stack/bar_chart_stack_event.dart';
import 'package:flutter_chart_exam/view/bar_chart_stack/bar_chart_stack_state.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class BarChartStackBloc extends BaseBloc<BarChartStackState> {
  Api api;
  BarChartStackBloc(this.api) : super(BarChartStackState());

  @override
  Stream<BarChartStackState> mapEventToState(BaseEvent event) async* {
    if (event is BarChartStackEvent) {
      yield state.copyWith(isLoading: true);
      var resultVN = await api.getDataCovid();
      var resultCam = await api.getDeathsCampuchia();
      print(resultCam.All.dates.length);
      yield state.copyWith(
          isLoading: false, covidModelVN: resultVN, covidModelCam: resultCam);
    }
  }
}
