import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HtmlPage extends StatefulWidget {
  @override
  _HtmlPageState createState() => _HtmlPageState();
}

class _HtmlPageState extends State<HtmlPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('网页'),
      ),
      body: WebView(
        initialUrl: "https://v.youku.com/v_show/id_XNDcxNTQ3MDUwOA==.html",
      ),
    );
  }
}
