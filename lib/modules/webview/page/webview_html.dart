import 'package:flutter/material.dart';
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
        body: WebView(
          initialUrl: 'https://v.youku.com/v_show/id_XNDcxNTQ3MDUwOA==.html',
          javascriptMode: JavascriptMode.unrestricted,
        )
//      Center(
//        child: FlatButton(
//          onPressed: () {
//            Navigator.push(
//              context,
//              MaterialPageRoute(builder: (_) {
//                return WebViewPage(
//                  url:
//                      "https://v.youku.com/v_show/id_XNDcxNTQ3MDUwOA==.html",
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
