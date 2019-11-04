import 'package:flutter/material.dart';
import 'package:loopic_flutter/module/image_manager.dart';

class InitWidget extends StatelessWidget {
//  const InitWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
//    SystemChrome.setPreferredOrientations(
//        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    ImageManager.getInstance().preFetchIndex(0);
    ImageManager.getInstance().preFetchIndex(1);
    ImageManager.getInstance().preFetchIndex(2);
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
