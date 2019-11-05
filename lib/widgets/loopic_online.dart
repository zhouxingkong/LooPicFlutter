import 'package:dio/dio.dart';
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
//    print("移除前${imageCache.currentSize}");
    return networkImage.evict();
//    Future<NetworkImage> key = networkImage.obtainKey(null);
//    imageCache.evict(key);
//    print("移除后${imageCache.currentSize}");
  }

  @override
  Widget build(BuildContext context) {
    print("build");

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
//                                changeImage(context,index);

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
//                semanticLabel:"第${_ser}",
//                loadingBuilder:(
//                  BuildContext context,
//                  Widget child,
//                  ImageChunkEvent loadingProgress){
//                  return Text("ser:${_ser}");
//                }
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
