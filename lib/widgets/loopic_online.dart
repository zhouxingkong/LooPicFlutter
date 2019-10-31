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

  String _url = "http://192.168.1.107:8080/loopicserver/show/0";
  int index = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);

    return Container(
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                      flex: 4,
                      child: FlatButton(
                        child: Text(
                          '文字描述',
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            index++;
                            _url =
                            "http://192.168.1.107:8080/loopicserver/show/$index";
                            print(_url);
                          });
                        },
                      )
                  ),
                  Divider(color: Colors.grey),
                  Expanded(
                    flex: 1,
                    child: Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            child: Text(
                              '◀',
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                            onPressed: () { //显示上一张图片
                              setState(() {
                                if (index > 0) {
                                  index--;
                                  _url =
                                  "http://192.168.1.107:8080/loopicserver/show/$index";
                                }
                              });
                            },
                          ),
                        ),
                        VerticalDivider(color: Colors.grey),
                        Expanded(
                          flex: 1,
                          child: FlatButton(
                            child: Text(
                              '▼',
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                            onPressed: () { //换图
                              setState(() {

                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
          ),
          VerticalDivider(color: Colors.grey),
          Expanded(
            flex: 2,
            child: Image(
              image: NetworkImage(_url),
            ),
          ),
        ],
      ),

    );
  }
}
