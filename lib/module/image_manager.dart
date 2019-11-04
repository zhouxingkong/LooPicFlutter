import 'package:flutter/painting.dart';

/**
 * 图片管理类，实现网络图片的预加载
 */
class ImageManager {
  ImageManager._();

  static ImageManager _instance;
  Map<String, NetworkImage> imageCache = {};

  static ImageManager getInstance() {
    if (_instance == null) {
      _instance = ImageManager._();
    }
    return _instance;
  }

  void preFetchIndex(int index) {
    if (!imageCache
        .containsKey("http://192.168.43.139:8080/loopicserver/show/$index")) {
      NetworkImage networkImage = NetworkImage(
        "http://192.168.43.139:8080/loopicserver/show/$index",
      );
      networkImage.load(networkImage);
      imageCache["http://192.168.43.139:8080/loopicserver/show/$index"] =
          networkImage;
    }
  }

  NetworkImage getImage(String url) {
    if (imageCache.containsKey(url)) {
      return imageCache[url];
    } else {
      ImageProvider imageProvider = NetworkImage(url);
      imageCache[url] = imageProvider;
      return imageProvider;
    }
  }
}
