import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loopic_flutter/module/url_manager.dart';
/**
 * 图片管理类，实现网络图片的预加载
 */
class ImageManager {

  /**
   * 清空服务端所有图片缓存
   */
  static void evictAllCache() {
    ImageCache imageCache = PaintingBinding.instance.imageCache;
    imageCache.clear(); //首先清空图片缓存

    evictServer();
  }

  static void evictServer() async {
    Dio().post("${UrlManager.evict_url}");
  }
}
