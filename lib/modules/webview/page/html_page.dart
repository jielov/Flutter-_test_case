import 'package:flutter/material.dart';
import 'package:videotest/modules/html_flutter_inappwebview/inapp_web_view.dart';
import 'package:videotest/modules/webview/view/web_view_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HtmlPage extends StatefulWidget {
  @override
  _HtmlPageState createState() => _HtmlPageState();
}

class _HtmlPageState extends State<HtmlPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('网页'),
//      ),
      body: WebViewPage(
        url: 'https://haokan.baidu.com/v?vid=4577391648901297316&pd=bjh&fr=bjhauthor&type=video',
        title: '视频播放',
      ),
    );
  }
}
