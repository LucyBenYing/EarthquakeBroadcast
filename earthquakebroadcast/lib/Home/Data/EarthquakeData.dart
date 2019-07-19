
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; 
import 'EarthquakeRspData.dart';
import 'EarthquakeItemData.dart';
import 'package:shared_preferences/shared_preferences.dart';



class BaseRequest {
  String baseUrl = 'http://www.nicecw.com';
  String path;
  Dio dio ;
  Map<String,dynamic> params; 
  BaseRequest(this.baseUrl,this.path,this.params) :dio = Dio(BaseOptions(headers: {'Authorization':'Basic ${base64Encode(utf8.encode('root:123456'))}'}));
  String  get requestUrl{
    return '$baseUrl$path';
  }
  
}

class EQGetListRequest extends BaseRequest {
  String page = '1';
  String size = '2'; 
  
  EQGetListRequest({
    baseUrl = 'http://www.nicecw.com',
    path = '/data_api/getlist',
    params,
    this.page,
    this.size,
    }) 
    : super(baseUrl,path,params) ;
    @override 
  Map<String, dynamic> get params {  
      return {'page':page,
         'size': size};
  } 
}

class EQGetDetsailRequest extends BaseRequest {
  String id ; 
  
  EQGetDetsailRequest({
    baseUrl = 'http://www.nicecw.com',
    path = '/data_api/getid',
    params,
    this.id,
    }) 
    : super(baseUrl,path,params) ;
    @override 
  Map<String, dynamic> get params {  
      return {'id':id,
        };
  } 
}


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
Future<List<EarthquakeItemData>> getHomePageDatas(int page,int size) async{
try {
 EQGetListRequest req = EQGetListRequest(
    page: page.toString(),
    size: size.toString(), 
  );
    final String  url =  req.requestUrl;
    // print('开始请求数据 $url,reqs = ${req.params}');
    Response response = await req.dio.get(url,queryParameters: req.params); 
    // print('response========\n$response ');
    // print('\n======== 返回数据\n${response.data}');
    if (response.data != null) { 
      return getRspDatas(response.data).data;
    } else {
      return [];
    }
  }catch (e) {
    print(e); 
  }
}

EarthquakeRspData getRspDatas(Map<String, dynamic> datas) {
 final data = EarthquakeRspData.formJson(datas); 
 return data;
}

// 详情页数据
Future<EarthquakeItemData> getDetailData(int itemId) async{  
    try {  
       EQGetDetsailRequest req = EQGetDetsailRequest(
       id : itemId.toString(), 
       );
    final String  url =  req.requestUrl; 
    Response res = await req.dio.get(url,queryParameters: req.params);
     if (res.data != null) { 
      return getRspDatas(res.data).data.first;
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

