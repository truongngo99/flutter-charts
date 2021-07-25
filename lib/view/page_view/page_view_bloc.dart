import 'package:flutter_chart_exam/data/post/api.dart';
import 'package:flutter_chart_exam/view/page_view/page_view_event.dart';
import 'package:flutter_chart_exam/view/page_view/page_view_state.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class PageViewBloc extends BaseBloc<PageViewState> {
  Api api;
  PageViewBloc(this.api) : super(PageViewState());

  @override
  Stream<PageViewState> mapEventToState(BaseEvent event) async* {
    if (event is PageViewEvent) {
      yield state.copyWith(isLoading: true);
      var result = await api.getDataCountryCode(event.code);
      yield state.copyWith(isLoading: false, covidModel: result);
    }
  }
}
