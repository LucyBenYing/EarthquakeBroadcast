import 'package:flutter/material.dart'; 
import 'package:earthquakebroadcast/Home/Data/EarthquakeItemData.dart';

class EarthquakeDetailPage extends StatelessWidget {
  final EarthquakeItemData detailItem;
  EarthquakeDetailPage({this.detailItem});

  @override
  Widget build(BuildContext context) { 
   return MaterialApp(
     title:'详细信息',
     home: EarthquakeDetailView(
       detailItem: detailItem,
     ),
   );
  }
}

class EarthquakeDetailView extends StatelessWidget {
  final EarthquakeItemData detailItem;
  EarthquakeDetailView({this.detailItem});
  @override
  Widget build(BuildContext context) { 
     return Scaffold(
       appBar: new AppBar(
         title: new Text('地震详细信息'),
       ) ,
       body: new Column (
        children: <Widget>[
          new DetailInfoItem(
          name: '位置',
          value: detailItem.location,
        ),
           new DetailInfoItem(
          name: '震级',
          value: detailItem.m.toString(),
        ),
            new DetailInfoItem(
          name: '时刻',
          value: detailItem.readTimestamp(detailItem.time),
        ),
            new DetailInfoItem(
          name: '维度',
          value: detailItem.epiLat.toString(),
        ),
            new DetailInfoItem(
          name: '经度',
          value: detailItem.epiLon.toString(),
        ),
            new DetailInfoItem(
          name: '深度',
          value: detailItem.epiDepth.toString(),
        ),
        ],
       ),
     );
  }
}

class DetailInfoItem extends StatelessWidget {
final String name;
final String value;
DetailInfoItem({
  this.name,
  this.value,
});

@override
  Widget build(BuildContext context) { 
    return Container(
      padding: new EdgeInsets.all(20.0),
      child:  new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // new Expanded(
            new Text(
               name ,
               style: _getTextStyle(true)
             ),
          //  ),
          new Expanded(
            
            child: new  Container(
              padding: new EdgeInsets.symmetric(horizontal: 20.0),
              child:  new Text(
               value ,
               style: _getTextStyle(false)
             ),
            ),
           ),
        ],
      ),  
    );
  }

  TextStyle _getTextStyle(bool name) {
    var style  ;
    if (name) {
      style = new TextStyle(
        color: Colors.black,
        fontSize: 20.0,
      );
    } else {
       style = new TextStyle(
         color: Colors.grey,
         fontSize: 18.0,
       );
    }
    return style;
  }

}
