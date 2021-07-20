// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'properti.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Properties _$PropertiesFromJson(Map<String, dynamic> json) {
  return Properties(
    json['Code'] as String,
    json['Name_VN'] as String,
    json['active'] as int,
    json['death'] as int,
    json['infected'] as int,
    json['Name'] as String,
    json['recovered'] as int,
  );
}

Map<String, dynamic> _$PropertiesToJson(Properties instance) =>
    <String, dynamic>{
      'Code': instance.Code,
      'Name': instance.Name,
      'infected': instance.infected,
      'death': instance.death,
      'recovered': instance.recovered,
      'active': instance.active,
      'Name_VN': instance.Name_VN,
    };
