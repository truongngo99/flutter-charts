import 'package:flutter_chart_exam/data/post/api.dart';
import 'package:flutter_chart_exam/view/detail_chart/detail_chart_event.dart';
import 'package:flutter_chart_exam/view/detail_chart/detail_chart_state.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class DetailChartBloc extends BaseBloc<DetailChartState> {
  Api api;
  DetailChartBloc(this.api) : super(DetailChartState());

  @override
  Stream<DetailChartState> mapEventToState(BaseEvent event) async* {
    if (event is DetailChartEvent) {
      yield state.copyWith(isLoading: true);
      var result = await api.getDetailCountry(event.code, event.status);
      yield state.copyWith(isLoading: false, covidModel: result);
    }
  }
}
