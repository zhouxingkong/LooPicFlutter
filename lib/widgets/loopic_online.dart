/**
 * 网络图片
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoopicOnlineWidget extends StatefulWidget {
  @override
  _LoopicOnlineWidgetState createState() => _LoopicOnlineWidgetState();
}

class _LoopicOnlineWidgetState extends State<LoopicOnlineWidget> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);

    return Container();
  }
}
