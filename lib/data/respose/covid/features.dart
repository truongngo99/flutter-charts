import 'package:json_annotation/json_annotation.dart';
part 'features.g.dart';

@JsonSerializable()
class AllData {
  int? confirmed;
  int? recovered;
  int? deaths;
  String country;
  String? updated;
  String? abbreviation;
  Map<String, dynamic>? dates;

  AllData(this.dates, this.confirmed, this.deaths, this.recovered, this.updated,
      this.country, this.abbreviation);
  factory AllData.fromJson(Map<String, dynamic> json) =>
      _$AllDataFromJson(json);
  Map<String, dynamic> toJson() => _$AllDataToJson(this);
}
