import 'package:flutter/material.dart';
import 'package:videotest/modules/html_flutter_inappwebview/inapp_web_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewHtmlPage extends StatefulWidget {
  @override
  _WebViewHtmlPageState createState() => _WebViewHtmlPageState();
}

class _WebViewHtmlPageState extends State<WebViewHtmlPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('网页视频播放'),
      ),
      body:
        WebView(
          initialUrl: 'http://www.iqiyi.com/v_19ry0opves.html',
          javascriptMode: JavascriptMode.unrestricted,
        )
//          Center(
//        child: FlatButton(
//          onPressed: () {
//            Navigator.push(
//              context,
//              MaterialPageRoute(builder: (_) {
//                return WebViewPage(
//                  url: "https://www.iqiyi.com/v_19rws0ura0.html",
//                  title: "aaa",
//                );
//              }),
//            );
//          },
//          child: Text('跳转'),
//          color: Colors.black38,
//        ),
//      ),
    );
  }
}
