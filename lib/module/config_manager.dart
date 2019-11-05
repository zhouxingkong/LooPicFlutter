import 'dart:convert' as convert;
import 'dart:io';

import 'package:loopic_flutter/module/url_manager.dart';

class ConfigManager {
  static bool enableSound = false;
  static List textList = [];

  static void loadTextOnline() async {
    try {
      //创建一个HttpClient
      HttpClient httpClient = new HttpClient();
      //打开Http连接
      HttpClientRequest request =
      await httpClient.getUrl(Uri.parse("${UrlManager.text_url}"));
      //等待连接服务器（会将请求信息发送给服务器）
      HttpClientResponse response = await request.close();
      //读取响应内容
      String ret = await response.transform(convert.utf8.decoder).join();
      textList = convert.json.decode(ret);
      //关闭client后，通过该client发起的所有请求都会中止。
      httpClient.close();
    } catch (e) {
      print(e);
    } finally {}
  }

  static String base64Decode(String data) {
    List<int> bytes = convert.base64Decode(data);
    return convert.utf8.decode(bytes);
  }

  static String getDecodeText(int index) {
    if (index < 0 || index >= textList.length) return "";
    String text = textList[index];
    return base64Decode(text);
  }
}
