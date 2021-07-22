// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'features.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllData _$AllDataFromJson(Map<String, dynamic> json) {
  return AllData(
    json['dates'] as Map<String, dynamic>?,
    json['confirmed'] as int?,
    json['deaths'] as int?,
    json['recovered'] as int?,
    json['updated'] as String?,
    json['country'] as String,
  );
}

Map<String, dynamic> _$AllDataToJson(AllData instance) => <String, dynamic>{
      'confirmed': instance.confirmed,
      'recovered': instance.recovered,
      'deaths': instance.deaths,
      'country': instance.country,
      'updated': instance.updated,
      'dates': instance.dates,
    };
