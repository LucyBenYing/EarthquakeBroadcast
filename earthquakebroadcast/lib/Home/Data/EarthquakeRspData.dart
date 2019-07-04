// import 'package:json_annotation/json_annotation.dart';
import 'EarthquakeItemData.dart';
//user.g.dart 将在我们运行生成命令后自动生成
// part 'EarthquakeRspData.g.dart';
//这个标注是告诉生成器，这个类是需要生成Model类的
// @JsonSerializable()
 
class EarthquakeRspData  {
  final int code;
  final String message;
  final List<EarthquakeItemData> data;

  EarthquakeRspData({ 
    this.code,
    this.message,
    this.data, 
  });

  factory EarthquakeRspData.formJson(Map<String, dynamic> json) {
    final originList = json['data'] as List;
    List<EarthquakeItemData> datas = originList.map( (value) => EarthquakeItemData.formJson(value)).toList();
   
    return EarthquakeRspData (
      code: json['code'],
      message: json['message'],
      data: datas,
    );
  }
    // Map<String, dynamic> toJson() => _$EarthquakeRspDataToJson(this);
  // factory EarthquakeListData.fromJson()
    Map<String,dynamic> toJson() =>
    <String, dynamic>{
      'code': this.code,
      'message': this.message,
      'data': this.data.toString(), 
    };
}
