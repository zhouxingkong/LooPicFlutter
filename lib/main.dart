import 'package:flutter/material.dart';
import 'package:loopic_flutter/routes.dart';


void main() {
//  SystemChrome.setPreferredOrientations([
//    DeviceOrientation.landscapeLeft,
//    DeviceOrientation.landscapeRight
//  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //去掉debug图标
      // home:Tabs(),
      initialRoute: '/', //初始化的时候加载的路由
      onGenerateRoute: onGenerateRoute,
    );
  }
}