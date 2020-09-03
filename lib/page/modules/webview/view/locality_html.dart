import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:videotest/view/base_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LocalityHtml extends StatefulWidget {
  @override
  _LocalityHtmlState createState() => _LocalityHtmlState();
}

class _LocalityHtmlState extends State<LocalityHtml> {
  WebViewController _webViewController;
  String filePath = 'html/privacy.html';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleStr: '', automaticallyImplyLeading: true)
          .commAppBar(context),
      body: WebView(
        initialUrl: '',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _webViewController = webViewController;
          _loadHtmlFromAssets();
        },
      ),
    );
  }

  _loadHtmlFromAssets() async {
    String fileHtmlContents = await rootBundle.loadString(filePath);
    _webViewController.loadUrl(Uri.dataFromString(fileHtmlContents,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
