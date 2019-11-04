/**
 * 网络图片
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopic_flutter/module/url_manager.dart';

class LoopicOnlineWidget extends StatefulWidget {
  @override
  _LoopicOnlineWidgetState createState() => _LoopicOnlineWidgetState();
}

class _LoopicOnlineWidgetState extends State<LoopicOnlineWidget> {

  String _url = "${UrlManager.show_url}0";
  int index = 0;

  void _nextImage() {
    index++;
    _url = "${UrlManager.show_url}${index}";
//    ImageManager.getInstance().preFetchIndex(index + 1);
//    ImageManager.getInstance().preFetchIndex(index + 2);
  }

  void _preImage() {
    if (index > 0) {
      index--;
      _url = "${UrlManager.show_url}${index}";
    }
//    ImageManager.getInstance().preFetchIndex(index+1);
//    ImageManager.getInstance().preFetchIndex(index+2);
  }

  void _preloadImage(BuildContext context, int nextIndex) {
    precacheImage(new NetworkImage(
        "${UrlManager.show_url}${nextIndex}"), context);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);

    _preloadImage(context, index + 1);
    _preloadImage(context, index + 2);

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
                      child: GestureDetector(
                        child: Text(
                          '文字描述',
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                        onTap: () { //单次点击下一张图片
                          setState(() {
                            _nextImage();
                          });
                        },
                        onDoubleTap: () { //双次点击回退
                          setState(() {
                            _preImage();
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
                                _preImage();
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
            child: GestureDetector(
              child: Image(
                image: NetworkImage(_url),
              ),
              onHorizontalDragUpdate: (DragUpdateDetails details) {
//                _nextImage();
                print("delta= $details.delta");
              },
            ),
          ),
        ],
      ),

    );
  }
}
