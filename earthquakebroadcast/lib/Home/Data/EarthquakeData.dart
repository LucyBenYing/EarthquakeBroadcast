import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; 
import 'EarthquakeRspData.dart';
import 'EarthquakeItemData.dart';

class EarthquakeData extends StatelessWidget {
  final String  url = 'http://www.nicecw.com/api/getlist';
  final String datas = 
  '''
  {
    "code": 200,
    "msg": "\u6210\u529f",
    "data": [
        
        {
            "id": 143,
            "m": 6.3,
            "time": 1561544290.0,
            "epi_lat": 56.01,
            "epi_lon": 164.09,
            "location": "\u79d1\u66fc\u591a\u5c14\u7fa4\u5c9b\u5730\u533a[\u4fc4]"
        },
        {
            "id": 142,
            "m": 3.3,
            "time": 1561509219.0,
            "epi_lat": 28.42,
            "epi_lon": 104.8,
            "location": "\u56db\u5ddd\u5b9c\u5bbe\u5e02\u73d9\u53bf"
        },
        {
            "id": 141,
            "m": 3.4,
            "time": 1561509196.0,
            "epi_lat": 28.39,
            "epi_lon": 104.81,
            "location": "\u56db\u5ddd\u5b9c\u5bbe\u5e02\u73d9\u53bf"
        },
        {
            "id": 140,
            "m": 2.9,
            "time": 1561495534.0,
            "epi_lat": 28.42,
            "epi_lon": 104.79,
            "location": "\u56db\u5ddd\u5b9c\u5bbe\u5e02\u73d9\u53bf"
        },
        {
            "id": 139,
            "m": 6.1,
            "time": 1561482341.0,
            "epi_lat": 56.18,
            "epi_lon": 164.34,
            "location": "\u79d1\u66fc\u591a\u5c14\u7fa4\u5c9b\u5730\u533a"
        },
        {
            "id": 138,
            "m": 5.7,
            "time": 1561471309.0,
            "epi_lat": -48.01,
            "epi_lon": 99.65,
            "location": "\u4e1c\u5357\u5370\u5ea6\u6d0b\u6d77\u5cad"
        },
        {
            "id": 137,
            "m": 3.2,
            "time": 1561432485.0,
            "epi_lat": 37.62,
            "epi_lon": 77.79,
            "location": "\u65b0\u7586\u548c\u7530\u5730\u533a\u76ae\u5c71\u53bf"
        }
    ]
}
''';

  // const EarthquakeData({Key key, this.url}) : super(key: key);
@override
Widget build(BuildContext context) { 
    return Center(); 
}

Future <EarthquakeRspData> getHttp() async {
  try {
    Response response = await Dio().get(url); 
    print(response);
    if (response.data != null) {
      // return  getDats(response.data);
      return getRspDatas(response.data);
    } else {
      return null;
    }
    
  }catch (e) {
    print(e);
    return null;
  }
}



List<EarthquakeItemData> getDats( List<Map<String,dynamic>> datas){
    // 模型序列化  
    return  datas.map( (value) {
      return new EarthquakeItemData.formJson(value);
    }).toList();  
  }
}

// 首页数据
Future<List<EarthquakeItemData>> getHomePageDatas() async{
try {
    final String  url = 'http://www.nicecw.com/api/getlist';
    Response response = await Dio().get(url); 
    print(response);
    if (response.data != null) {
      // return  getDats(response.data);
      return getRspDatas(response.data).data;
    } else {
      return null;
    }

  }catch (e) {
    print(e);
    return null;
  }
}

EarthquakeRspData getRspDatas(Map<String, dynamic> datas) {
return new EarthquakeRspData.formJson(datas);
}

// 详情页数据
Future<EarthquakeItemData> getDetailData(double itemId) async{ 
    try {
       final url = 'http://www.nicecw.com/api/getid';
    final    Map<String, dynamic> params = {'id': itemId};
    final dio = new Dio();
    Response res = await dio.get(
      url,
      queryParameters: params,
    );
    print(res);
    if (res.data != null) {
      // return ea
    }
    return null;
    } catch (e) {
      print(e);
      return null;
    }
   
  }
