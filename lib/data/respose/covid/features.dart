import 'package:flutter_chart_exam/data/respose/covid/properti.dart';
import 'package:json_annotation/json_annotation.dart';
part 'features.g.dart';

@JsonSerializable()
class AllData {
  Map<String, dynamic> dates;

  AllData(this.dates);
  factory AllData.fromJson(Map<String, dynamic> json) =>
      _$AllDataFromJson(json);
  Map<String, dynamic> toJson() => _$AllDataToJson(this);
}
