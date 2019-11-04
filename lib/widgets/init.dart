import 'package:flutter/material.dart';

class InitWidget extends StatelessWidget {
//  const InitWidget({Key key}) : super(key: key);

  void _preloadImage(BuildContext context, int nextIndex) {
    precacheImage(new NetworkImage(
        "http://192.168.43.139:8080/loopicserver/show/$nextIndex"), context);
  }

  @override
  Widget build(BuildContext context) {
//    SystemChrome.setPreferredOrientations(
//        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    _preloadImage(context, 0);
    _preloadImage(context, 1);
    _preloadImage(context, 2);

    return Scaffold(
      appBar: AppBar(
        title: Text("Loopic"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('准备好面对疾风'),
            onPressed: () {},
          ),
          RaisedButton(
            child: Text('网络疾风'),
            onPressed: () {
              Navigator.pushNamed(context, "/loopic/online");
            },
          ),
        ],
      ),
    );
  }
}
