// import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart'; 
//user.g.dart 将在我们运行生成命令后自动生成
part 'EarthquakeItemData.g.dart';
//这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()

class EarthquakeItemData  {
  final double id;
  final double m;
  final double time;

  @JsonKey(name: 'epi_lat')
  final double epiLat;

  @JsonKey(name: 'epi_lon')
  final double epiLon;

   @JsonKey(name: 'epi_depth')
  final double epiDepth;
  
  final String location;
 
  const EarthquakeItemData(
    this.id,
    this.m,
    this.time,
    this.epiLat,
    this.epiLon,
    this.epiDepth,
    this.location
  );
// 不同的类使用不同的minxin即可
  factory EarthquakeItemData.formJson(Map<String, dynamic> json) => _$EarthquakeItemDataFromJson(json);
    Map<String, dynamic> toJson() => _$EarthquakeItemDataToJson(this);

String readTimestamp (double timestamp) {
  int times =  timestamp.toInt() * 1000; 
  var date = new DateTime.fromMillisecondsSinceEpoch(times); 
  return date.toString();
}
}
