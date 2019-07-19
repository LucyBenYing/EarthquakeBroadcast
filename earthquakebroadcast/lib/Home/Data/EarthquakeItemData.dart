// import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart'; 
//user.g.dart 将在我们运行生成命令后自动生成
part 'EarthquakeItemData.g.dart';
// import 'package:intl/intl.dart';
//这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()

class EarthquakeItemData  {
  final double id;
  final double m;
  final String time;

  @JsonKey(name: 'epi_lat')
  final double epiLat;

  @JsonKey(name: 'epi_lon')
  final double epiLon;

   @JsonKey(name: 'epi_depth',nullable: true)
  final double epiDepth;
  
  final String location;
 

   @JsonKey(name: 'auto_flag',nullable: true)
  final String autoFlag;
 
  const EarthquakeItemData(
    this.id,
    this.m,
    this.time,
    this.epiLat,
    this.epiLon,
    this.epiDepth,
    this.location,
    this.autoFlag
  );
// 不同的类使用不同的minxin即可
  factory EarthquakeItemData.formJson(Map<String, dynamic> json) => _$EarthquakeItemDataFromJson(json);
    Map<String, dynamic> toJson() => _$EarthquakeItemDataToJson(this);

String readTimestamp (double timestamp) {
  if (timestamp == null) {
    return '';
  }
  int times =  timestamp.toInt() * 1000; 
  var date = new DateTime.fromMillisecondsSinceEpoch(times).toLocal(); 
  final year = '${date.year}';
  final month = date.month >= 10 ? '${date.month}' : '0${date.month}';
  final day = date.day >= 10 ? '${date.day}' : '0${date.day}';
  final hour = date.hour >= 10 ? '${date.hour}' : '0${date.hour}';
  final minute = date.minute >= 10 ? '${date.minute}' : '0${date.minute}';
  final second = date.second >= 10 ? '${date.second}' : '0${date.second}'; 

  String str = '$year-$month-$day $hour:$minute:$second';
  return  str;
}

bool isAutoFlag(String str){
  if (str == 'M') {
    return true;
  } else {
    return false;
  }
}

}
