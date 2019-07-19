import 'package:flutter/material.dart'; 
import 'package:earthquakebroadcast/Home/Data/EarthquakeItemData.dart';  
import 'package:earthquakebroadcast/Home/Data/EarthquakeData.dart';
import 'EarthquakeDetailPage.dart';   

class EarthquakeHomePage extends StatefulWidget {
  @override
  _EarthquakeHomePageState createState() => _EarthquakeHomePageState();
}

class _EarthquakeHomePageState extends State<EarthquakeHomePage> {
  ScrollController _scrollController = new ScrollController();
  List<EarthquakeItemData> earthquakeList = [];
  int page = 1 ;
  int size = 20;
  bool isLoadMore = false;
  bool isRefresh = false;

  @override
  void dispose() { 
    super.dispose();
    // 移除监听
    _scrollController.dispose();
  }

  @override
  void initState() { 
    super.initState();  
    _loadData();
    _scrollController.addListener((){
      if(_scrollController.position.pixels ==
       _scrollController.position.maxScrollExtent){
         print( 'jiazai gengduo ');
        _getMoreData();
      }
    });
  }

 Future<bool> _getMoreData() async{
   if(!isLoadMore){
     setState(() {
       isLoadMore = true;
     });
      page ++; 
   return await _loadData();
   }
   
  }
  
  Future<bool> _loadData() async{ 
       await getHomePageDatas(page,size).then((List<EarthquakeItemData> onvalue){
      if (onvalue == null){
        return false;
      } 
        setState(() {
            if(isRefresh){
                earthquakeList.clear();
                isRefresh = false;
            }
            isLoadMore = false;
            earthquakeList.addAll(onvalue);
          }); 
      return true;
    }).catchError( (error){
      print(error);
      return false;
    });
  }

  Future<bool> _onRefresh() async{
    page = 1;
    isRefresh = true;
   return await _loadData();
  }
   
  @override
  Widget build(BuildContext context) {  
    // addHandelr(context);
    return new Scaffold(
     appBar: new AppBar(
      title: new Text('地震信息'),
       actions: <Widget>[
         new  IconButton(
           icon: new Icon(Icons.room_service),
           tooltip: '退出',
           onPressed: (){
             Navigator.pushNamedAndRemoveUntil(context,
             '/login',
              (Route route)=> false);
           },
         )
       ],
     ),
     body: _refreshAndLoadMore(context),
    );
  }

  Widget _refreshAndLoadMore (BuildContext context){
    return new RefreshIndicator(
      displacement: 50,
      color: Colors.redAccent,
      backgroundColor: Colors.blue,
      child: ListView.builder(
        itemBuilder: (BuildContext context ,int index){
          print('创建数据--- $index ${earthquakeList.length}');
          if (index == earthquakeList.length ) {
            return LoadMoreView();
          } else {
            return EarthquakeListItem(item: earthquakeList[index]);
          }
        },
        itemCount: earthquakeList.length + 1,
        controller: _scrollController,
      ),
      onRefresh: _onRefresh,
    );
  
  }
 
  Widget _getInfoWidget(BuildContext context){
 return  FutureBuilder(
      future: _loadData(),
      builder: (context, snapshot) {
        if(earthquakeList.length > 0) {
          return _refreshAndLoadMore(context); 
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
    final tiemStr = item.time; 
    return new Container(
      color: item.isAutoFlag(item.autoFlag) ?
     null : Colors.yellow[100],
      child:  new  ListTile(
      
      onTap: (){
        Navigator.push(
          context, 
          new MaterialPageRoute(
            builder: (context) => EarthquakeDetailView(itemId: item.id.toInt())
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


class LoadMoreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 
    return new Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row (
          
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('加载中、。。。',
            style: TextStyle(fontSize: 16),),
            CircularProgressIndicator(strokeWidth: 1.0,),
          
          ],),
      ),
    );
  }
}