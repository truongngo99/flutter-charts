import 'package:flutter_chart_exam/view/widget/drawer_event.dart';
import 'package:flutter_chart_exam/view/widget/drawer_state.dart';
import 'package:teq_flutter_core/teq_flutter_core.dart';

class DrawerBloc extends BaseBloc<DrawerState> {
  DrawerBloc() : super(DrawerState());

  @override
  Stream<DrawerState> mapEventToState(BaseEvent event) async* {
    if (event is DrawerEvent) {
      yield state.copyWith(index: event.indexClick);
      print(state.index);
    }
  }
}
