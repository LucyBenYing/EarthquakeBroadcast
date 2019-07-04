import 'package:flutter/material.dart'; 
import 'package:earthquakebroadcast/Home/Data/EarthquakeItemData.dart';
import 'package:earthquakebroadcast/Home/Data/EarthquakeData.dart';
import 'EarthquakeDetailPage.dart';

class EarthquakeApp  extends StatefulWidget {
  @override
  _EarthquakeAppState createState() => _EarthquakeAppState();
}

class _EarthquakeAppState extends State<EarthquakeApp> {
  String dateStr = "";
  var earthquakeDatas = [];

  @override
  Widget build(BuildContext context) { 
      return layout(context);
  }

  @override
  void initState() { 
    super.initState();
    getDatas();
  }

 
  void getDatas() {
    EarthquakeData earth = EarthquakeData();
     earth.getHttp().then((reslut) {
       setState(() {
          earthquakeDatas = reslut.data;
      print('拿到数据了');
       }); 
    }).whenComplete((){
      print('异步任务完成');
    }).catchError((error){
      print('异常了$error');
    });  
  } 
  
  Widget layout(BuildContext context) {  
    return MaterialApp(
      title: '地震数据',
      home: EarthquakeHomePage(
        earthquakeDatas: new List<EarthquakeItemData>.from(earthquakeDatas),
      ),
    );
  }
}

class EarthquakeHomePage extends StatelessWidget {
  EarthquakeHomePage({this.earthquakeDatas});
  final List<EarthquakeItemData> earthquakeDatas;

  @override
  Widget build(BuildContext context) {  
    return EarthquakeListView(earthquakeDatas: earthquakeDatas);
  }
}

class EarthquakeListItem extends StatelessWidget {
  final EarthquakeItemData item;
  EarthquakeListItem({this.item}) : super(key: ObjectKey(item));
  @override
  Widget build(BuildContext context) {
    final tiemStr = item.readTimestamp(item.time); 
    return ListTile(
      onTap: (){
        Navigator.push(
          context, 
          new MaterialPageRoute(
            builder: (context) => EarthquakeDetailPage(detailItem: item)
          )
        );
      },
      isThreeLine: true,
      leading:  new CircleAvatar(
         backgroundColor: _getColor(item.m),
         child:  new Text(
           item.m.toString(),
           style: new TextStyle(
             color: Colors.white54,
           ),
         ),
       ),
       title: new Text(
        '震源位置: ${item.location}',

       ),
       subtitle: new Text( 
        '时间: $tiemStr \n震源: ( ${item.epiLat} , ${item.epiLon} )', 
       ),
    );
  }
  Color _getColor(double m) {
    final bool light = m < 5;
    if (light) return Colors.green;
    else return Colors.red;
  }
}

class EarthquakeListView extends StatelessWidget {
  EarthquakeListView({this.earthquakeDatas});
  final List<EarthquakeItemData> earthquakeDatas;
  @override
  Widget build(BuildContext context) { 
     return new Scaffold(
     appBar: new AppBar(
       title: new Text('地震信息'),
     ),
     body: new ListView(
       padding: new EdgeInsets.symmetric(vertical: 8.0),
       children: earthquakeDatas.map((EarthquakeItemData product){
        return new EarthquakeListItem(
          item: product, 
        );
       }).toList(),
     ), 
   );
  }
}

