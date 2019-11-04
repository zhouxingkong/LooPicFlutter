class UrlManager {
  static String url_base = "http://192.168.43.139:8080";
  static String show_url = "${url_base}/loopicserver/show/";

  static void setUrl(String urlBase) {
    url_base = "http://${urlBase}:8080";
    show_url = "${url_base}/loopicserver/show/";
  }
}
