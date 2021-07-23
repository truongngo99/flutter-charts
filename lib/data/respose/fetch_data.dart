import 'package:charts_flutter/flutter.dart' as charts;

class FetchData {
  final String date;
  final int value;
  final charts.Color barColor;

  FetchData(this.date, this.value, this.barColor);
}
