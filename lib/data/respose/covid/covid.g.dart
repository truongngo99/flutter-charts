// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CovidModel _$CovidModelFromJson(Map<String, dynamic> json) {
  return CovidModel(
    AllData.fromJson(json['All'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CovidModelToJson(CovidModel instance) =>
    <String, dynamic>{
      'All': instance.All,
    };
