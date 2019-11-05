import 'package:dio/dio.dart';
/**
 * 网络图片
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loopic_flutter/module/config_manager.dart';
import 'package:loopic_flutter/module/url_manager.dart';

class LoopicOnlineWidget extends StatefulWidget {
  @override
  _LoopicOnlineWidgetState createState() => _LoopicOnlineWidgetState();
}

class _LoopicOnlineWidgetState extends State<LoopicOnlineWidget> {

  String _url = "${UrlManager.show_url}0";
  double _scale = 1.0;
  int index = 0;

//  GlobalKey<> textKey = GlobalKey();

  void _nextImage() {
    index++;
    _url = "${UrlManager.show_url}${index}";
  }

  void _preImage() {
    if (index > 0) {
      index--;
      _url = "${UrlManager.show_url}${index}";
    }
  }

  /**
   * 更换图片
   */
  void changeImage(BuildContext context, int index) async {


  }


  Future<void> _preloadImage(BuildContext context, int nextIndex) {
    return precacheImage(new NetworkImage(
        "${UrlManager.show_url}${nextIndex}"), context);
  }

  Future<bool> removeFromCache(int index) {
    ImageCache imageCache = PaintingBinding.instance.imageCache;
    NetworkImage networkImage = new NetworkImage(
        "${UrlManager.show_url}${index}");
    return networkImage.evict();
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
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                      flex: 10,
                      child: GestureDetector(
                        child: Text(
                          "${ConfigManager.getDecodeText(index)}",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            decoration: TextDecoration.none,
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
                        onLongPress: () { //长按换图
                          Future.wait([
                            Dio().post("${UrlManager.change_url}${index}"),
                            removeFromCache(index),
                            _preloadImage(context, index),
                          ]).then((response) {
                            setState(() {
                              index--;
                              _url = "${UrlManager.show_url}${index}";
                            });
                          })
                              .catchError((e) {
                            print(e);
                          });
                        },
                      )
                  ),
//                  Divider(color: Colors.grey),
//                  Expanded(
//                    flex: 1,
//                    child: Flex(
//                      direction: Axis.horizontal,
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      mainAxisSize: MainAxisSize.min,
//                      crossAxisAlignment: CrossAxisAlignment.stretch,
//                      children: <Widget>[
//                        Expanded(
//                          flex: 1,
//                          child: FlatButton(
//                            child: Text(
//                              '▼',
//                              textAlign: TextAlign.left,
//                              overflow: TextOverflow.clip,
//                              style: TextStyle(
//                                color: Colors.white,
//                                fontSize: 18.0,
//                              ),
//                            ),
//                            onPressed: () { //换图
//                            },
//                          ),
//                        ),
//                        Expanded(
//                          flex: 1,
//                          child: FlatButton(
//                            child: Text(
//                              '◀',
//                              textAlign: TextAlign.left,
//                              overflow: TextOverflow.clip,
//                              style: TextStyle(
//                                color: Colors.white,
//                                fontSize: 18.0,
//                              ),
//                            ),
//                            onPressed: () { //显示上一张图片
//                              setState(() {
//                                _preImage();
//                              });
//                            },
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
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
            ),
          ),
        ],
      ),

    );
  }
}
