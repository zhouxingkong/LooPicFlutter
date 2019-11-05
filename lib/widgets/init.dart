import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopic_flutter/module/config_manager.dart';
import 'package:loopic_flutter/module/url_manager.dart';

class InitWidget extends StatefulWidget {
  @override
  _InitWidgetState createState() => _InitWidgetState();
}

class _InitWidgetState extends State<InitWidget> {

  bool _soundSwitch = false; //维护单选开关状态
  String _ipValue = "192.168.1.107";

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
  }

  void _preloadImage(BuildContext context, int nextIndex) {
    precacheImage(new NetworkImage(
        "${UrlManager.show_url}${nextIndex}"), context);
  }

  @override
  Widget build(BuildContext context) {
    _preloadImage(context, 0);
    _preloadImage(context, 1);
    _preloadImage(context, 2);
    ConfigManager.loadTextOnline();

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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.alarm),
              Switch(
                value: _soundSwitch, //当前状态
                onChanged: (value) {
                  //重新构建页面
                  setState(() {
                    _soundSwitch = value;
                  });
                },
              ),
            ],
          ),
          TextField(
            autofocus: false,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.cloud_download)
            ),
            onChanged: (String value) {
              _ipValue = value;
            },
            controller: TextEditingController.fromValue(
                TextEditingValue(
                  text: '${this._ipValue == null ? "" : this._ipValue}',
                  //判断keyword是否为空
                  // 保持光标在最后
                  selection: TextSelection.fromPosition(TextPosition(
                      affinity: TextAffinity.downstream,
                      offset: '${this._ipValue}'.length)
                  ),
                )
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: RaisedButton(
                  child: Text('准备好面对疾风'),
                  onPressed: () {},
                ),
              ),
              Expanded(
                flex: 1,
                child: RaisedButton(
                  child: Text('网络疾风'),
                  onPressed: () {
                    ConfigManager.enableSound = _soundSwitch; //是否开启声音
                    UrlManager.setUrl(_ipValue);
                    Navigator.pushNamed(context, "/loopic/online");

                    print("声音${_soundSwitch}");
                    print("ip:${_ipValue}");
                  },
                ),
              ),
            ],

          ),
        ],
      ),
    );
  }
}

