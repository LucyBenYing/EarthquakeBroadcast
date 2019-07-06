import 'package:flutter/material.dart'; 
// import 'package:lib/';
import 'package:earthquakebroadcast/Home/Views/HomePage.dart'; 
import 'package:earthquakebroadcast/Home/Push/JPushConfig.dart'; 


void main() {
 setupPush();
 runApp(
   EarthquakeHomeApp()  
 );
} 
// void MyApp(){}

void setupPush () {
   JPushConfig().setupPush();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 
    return new Center();
  }
  
}
