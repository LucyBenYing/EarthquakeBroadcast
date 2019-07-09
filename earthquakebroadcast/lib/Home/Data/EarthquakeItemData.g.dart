// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EarthquakeItemData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EarthquakeItemData _$EarthquakeItemDataFromJson(Map<String, dynamic> json) {
  return EarthquakeItemData(
      (json['id'] as num)?.toDouble(),
      (json['m'] as num)?.toDouble(),
      (json['time'] as num)?.toDouble(),
      (json['epi_lat'] as num)?.toDouble(),
      (json['epi_lon'] as num)?.toDouble(),
      (json['epi_depth'] as num)?.toDouble(),
      json['location'] as String,
      json['auto_flag'] as String);
}

Map<String, dynamic> _$EarthquakeItemDataToJson(EarthquakeItemData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'm': instance.m,
      'time': instance.time,
      'epi_lat': instance.epiLat,
      'epi_lon': instance.epiLon,
      'epi_depth': instance.epiDepth,
      'location': instance.location,
      'auto_flag': instance.autoFlag
    };
