import 'package:flutter/material.dart'; 
import 'package:earthquakebroadcast/Home/Data/EarthquakeItemData.dart';
 import 'package:earthquakebroadcast/Home/Data/EarthquakeData.dart';

class EarthquakeDetailView extends StatelessWidget { 
  final int itemId;
  EarthquakeDetailView({
    Key key, 
    @required this.itemId
  })
     : super(key: key);

  @override
  Widget build(BuildContext context) { 
     return Scaffold(
       appBar: new AppBar(
         title: new Text('地震详细信息'),
       ) ,
       body: _showWidget(context),
     );
  }

  Widget _showWidget(BuildContext context){
    return new Container(
      child:  new 
     FutureBuilder(
      future: getDetailData(itemId),
      builder: (context, snapshot) {
        print('$snapshot,dddd ${snapshot.hasData},,   ${snapshot.data}');
        if (snapshot.hasData) { 
          EarthquakeItemData item =  snapshot.data;
          print('形象细心 ${item.toJson()}');
          return _getInfoWidegt(item);
        } else if (snapshot.hasError){
          return new Center(
            child: new Text('${snapshot.hasError}')
          );
        } else {
          return new Center(
            child: new CircularProgressIndicator(),
          );
        }
      },
    )
    );
  }

  Widget _getInfoWidegt (EarthquakeItemData detailItem) {
    return new Column (
      mainAxisAlignment: MainAxisAlignment.start,
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
          value: detailItem.time,
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
          value: detailItem.epiDepth != null ? detailItem.epiDepth.toString() : '',
        ),
         new DetailInfoItem(
          name: '数据类型',
          value:  detailItem.isAutoFlag(detailItem.autoFlag)? '确定数据' : '自动数据',
        ),
        ],
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
               name != null ? name:'' ,
               style: _getTextStyle(true)
             ),
          //  ),
          new Expanded(
            
            child: new  Container(
              padding: new EdgeInsets.symmetric(horizontal: 20.0),
              child:  new Text(
                value != null ? value:'',
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
