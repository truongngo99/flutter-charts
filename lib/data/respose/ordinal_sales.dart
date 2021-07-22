import 'package:charts_flutter/flutter.dart' as charts;

class DataModel {
  final String catergory;
  final int? value;
  final charts.Color barColor;

  DataModel(this.catergory, this.value, this.barColor);
}
