import 'package:flutter/material.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
// import 'EarthquakeMian.dart';

class JPushConfig extends StatelessWidget {
  final  _jpushs = new JPush(); 

  void _startupJPush() async {
  print('初始化jpush');  
  _jpushs.setup(
    appKey:'f9481cd276b6f58e803558a5',
    channel:'THeChannel',
    production:false,
    debug:true,
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
  _jpushs.addEventHandler(

  onReceiveNotification:(Map<String, dynamic> message) async {
      print('flutter onReciveNotification: $message');
    },
  onOpenNotification:(Map<String, dynamic> message) async {
    print('Flutter onOpenNotificaiton $message');
    Navigator.pushNamed(context, "/detail");
  },
  onReceiveMessage:(Map<String, dynamic> message) async {
    print('flutter onReciveMessage: $message');
  },
  );
  
    return Container();
  }

void setupPush (){
  _addAuthority(); 
  _startupJPush();
}
}



