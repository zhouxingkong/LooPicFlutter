import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopic_flutter/module/image_manager.dart';
import 'package:loopic_flutter/routes.dart';


void main() {
//  SystemChrome.setPreferredOrientations([
//    DeviceOrientation.landscapeLeft,
//    DeviceOrientation.landscapeRight
//  ]);
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ImageManager.evictAllCache(); //清空所有图片缓存

    return MaterialApp(
      debugShowCheckedModeBanner: false, //去掉debug图标
//      theme: ThemeData(
//        buttonTheme: ButtonThemeData(
//            minWidth: double.infinity,
//            height: double.infinity
//        ),
//      ),
      // home:Tabs(),
      initialRoute: '/', //初始化的时候加载的路由
      onGenerateRoute: onGenerateRoute,
    );
  }
}