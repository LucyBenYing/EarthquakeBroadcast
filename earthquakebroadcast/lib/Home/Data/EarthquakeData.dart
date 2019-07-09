import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; 
import 'EarthquakeRspData.dart';
import 'EarthquakeItemData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EarthquakeData extends StatelessWidget {
  final String  url = 'http://www.nicecw.com/api/getlist'; 
@override
Widget build(BuildContext context) { 
    return Center(); 
}

Future <EarthquakeRspData> getHttp() async {
  try {
    Response response = await Dio().get(url); 
    print(response);
    if (response.data != null) { 
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
    // print(response);
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
Future<EarthquakeItemData> getDetailData(int itemId) async{  
    try {  
      final url = 'http://www.nicecw.com/api/getid';
      final    Map<String, dynamic> params = {'id': itemId};
      final dio = new Dio();
      Response res = await dio.get(
        url,
        queryParameters: params,
      );
      // print(res.data);
      Map<String,dynamic> map = res.data;
      if (res.data != null) { 
        EarthquakeItemData item =  EarthquakeItemData.formJson(map['data']);
        print(item.toString());
        return item;
      } else {
        return null;
      } 
      } catch (e) {
        print(e);
        return null;
    }
}

Future<bool> loginSuccess(String username, String password) async {
  try{
    if (username == null || password == null) {
      return false;
    }
    return true;
  }catch (e){
    print(e);
    return false;
  }
}

Future <bool>findUser() async {
  final mUserName = 'username';
  final mPassword = 'password'; 
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String username = prefs.getString(mUserName);
  String pass = prefs.getString(mPassword);
  print('get form database name = $username, pass = $pass');
  if (username == null) {
    return false;
  }
  if (pass == null) {
    return false;
  }
    return username.length > 0 && pass.length > 0;
}

