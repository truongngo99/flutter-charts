import 'package:json_annotation/json_annotation.dart';
part 'properti.g.dart';

@JsonSerializable()
class Properties {
  String Code;
  String Name;
  int infected;
  int death;
  int recovered;
  int active;
  String Name_VN;
  Properties(this.Code, this.Name_VN, this.active, this.death, this.infected,
      this.Name, this.recovered);
  factory Properties.fromJson(Map<String, dynamic> json) =>
      _$PropertiesFromJson(json);
  Map<String, dynamic> toJson() => _$PropertiesToJson(this);
}
