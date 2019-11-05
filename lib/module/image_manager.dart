import 'package:flutter/material.dart';
/**
 * 图片管理类，实现网络图片的预加载
 */
class ImageManager {

  static void evictAllCache() {
    ImageCache imageCache = PaintingBinding.instance.imageCache;
    imageCache.clear(); //首先清空图片缓存
  }
}
