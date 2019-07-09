import 'package:flutter/material.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:earthquakebroadcast/Home/Views/EarthquakeDetailPage.dart';

class JPushConfig extends StatelessWidget {
  final  _jpushs = new JPush(); 

  void _startupJPush() async {
  print('初始化jpush');  
  _jpushs.setup(
    appKey:'f9481cd276b6f58e803558a5',
    channel:'THeChannel',
    production:false,
    debug:false,
   );  
  var registrationId = await _jpushs.getRegistrationID();
  print('初始化成功$registrationId');
  }

  void _addAuthority () { 
      _jpushs.applyPushAuthority(new NotificationSettingsIOS(
        sound:true,
        alert:true,
        badge:true,
      ));
  }

  @override
  Widget build(BuildContext context) {  
    addHandelr(context);  
    return new Container();
  }

  void setupPush (){
    _addAuthority(); 
    _startupJPush();
  }
}


void addHandelr(BuildContext context) {
  final  _jpushs = new JPush(); 
  _jpushs.addEventHandler(

  onReceiveNotification:(Map<String, dynamic> message) async {
      print('lby -----  flutter onReciveNotification: $message');
    },
  onOpenNotification:(Map<String, dynamic> message) async {
    print('lby -----  flutter onOpenNotificaiton $message');
    final extras = message['extras'];
    final type = extras['type'];
    final int itemId = int.parse( extras['itemId']);
     print('lby -----  flutter onOpenNotificaiton type=$type, itemId=$itemId,context = $context');
     Navigator.push(
          context, 
          new MaterialPageRoute(
            builder: (context) => EarthquakeDetailView(itemId: itemId)
          ),
        ); 
  },
  onReceiveMessage:(Map<String, dynamic> message) async {
    print('lby -----  flutter onReciveMessage: $message');
  },
  );
}




