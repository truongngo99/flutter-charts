import 'package:teq_flutter_core/teq_flutter_core.dart';

class DetailChartEvent extends BaseEvent {
  final String code;
  final String status;
  DetailChartEvent(this.code, this.status);
}
