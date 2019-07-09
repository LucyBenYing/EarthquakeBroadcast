import 'package:earthquakebroadcast/Home/Data/EarthquakeData.dart';
import 'package:flutter/material.dart';  
import 'package:earthquakebroadcast/Home/Views/HomePage.dart';  
import 'package:earthquakebroadcast/Home/Push/JPushConfig.dart';  
import 'package:earthquakebroadcast/Home/Views/LoginPage.dart';

void main() {

 runApp(
   EarthquakeHomeApp()  
 );
  setupPush();
} 

 class EarthquakeHomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 
    return  new MaterialApp(
      title: '地震数据',  
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => new EarthquakeApp(),
        '/login': (BuildContext context) => new LoginPageApp(loginType: LoginType.login),
        '/register': (BuildContext context) => new LoginPageApp(loginType: LoginType.register),
        '/changePassword': (BuildContext context) => new LoginPageApp(loginType: LoginType.changePassword),
      }
    );
  }
}

class EarthquakeApp extends StatelessWidget {

Widget build(BuildContext context) {
    addHandelr(context);
    return  new FutureBuilder(
      future:  findUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          
          final succ = snapshot.data;
          if (succ) {
            return EarthquakeHomePage();
          } else {
            return LoginPageApp(loginType: LoginType.login,);
          }
        } else if (snapshot.hasError){
          return new Container(
            child:  new Center(
              child: new Text('${snapshot.error}'),
            ),
          );
        } else {
          return new Container(
            child:  new Center(),
          );
        }
      },
    );
  }
}

void setupPush () {
   JPushConfig().setupPush();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 
    return new Center();
  }
  
}
