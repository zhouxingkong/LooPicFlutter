class UrlManager {
  static String url_base = "http://192.168.31.226:8080";
  static String show_url = "${url_base}/loopicserver/show/";
  static String change_url = "${url_base}/changepic/";
  static String evict_url = "${url_base}/erasecache";
  static String text_url = "${url_base}/text/xingkong1313113";


  /**
   * 装载所有的URL
   */
  static void setUrl(String urlBase) {
    url_base = "http://${urlBase}:8080";
    show_url = "${url_base}/loopicserver/show/";
    change_url = "${url_base}/changepic/";
    evict_url = "${url_base}/erasecache";
    text_url = "${url_base}/text/xingkong1313113";
  }
}
