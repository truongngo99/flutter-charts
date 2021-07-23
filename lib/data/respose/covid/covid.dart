import 'package:flutter_chart_exam/data/respose/covid/features.dart';
import 'package:json_annotation/json_annotation.dart';
part 'covid.g.dart';

@JsonSerializable()
class CovidModel {
  AllData All;
  CovidModel(this.All);

  factory CovidModel.fromJson(Map<String, dynamic> json) =>
      _$CovidModelFromJson(json);
  Map<String, dynamic> toJson() => _$CovidModelToJson(this);
}
