import 'package:flutter/material.dart'; 
import 'package:earthquakebroadcast/Home/Data/EarthquakeItemData.dart';  
import 'package:earthquakebroadcast/Home/Data/EarthquakeData.dart';
import 'EarthquakeDetailPage.dart'; 

class EarthquakeHomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '地震数据',
      home: EarthquakeHomePage(),
    );
  }
}

class EarthquakeHomePage extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {  
    return new Scaffold(
     appBar: new AppBar(
       title: new Text('地震信息'),
     ),
     body: _getInfoWidget(context),
    );
  }

  Widget _getInfoWidget(BuildContext context){
 return  FutureBuilder(
      future: getHomePageDatas(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return  EarthquakeListView(earthquakeDatas: snapshot.data);
        } else if (snapshot.hasError){
          return new Center(
            child:  new Text('${snapshot.error}'),
          ) ;
        } else {
          return new Center(
            child: new CircularProgressIndicator(),
          );
        }
      }
    ) ;
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
            builder: (context) => EarthquakeDetailView(itemId: item.id)
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
    return  new ListView(
       padding: new EdgeInsets.symmetric(vertical: 8.0),
       children: earthquakeDatas.map((EarthquakeItemData product){
        return new EarthquakeListItem(
          item: product, 
        );
       }).toList(),
     
   );
  }
}

