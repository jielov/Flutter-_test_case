import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videotest/res/app_color.dart';
import 'package:videotest/view/base_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url, title;

  const WebViewPage({Key key, @required this.url, @required this.title})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> {
  bool _showLoading = true;

  WebViewController _controller;

  Future<bool> _back() async {
    if (_controller != null && await _controller.canGoBack()) {
      _controller.goBack();
      return new Future.value(false);
    } else {
      return new Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: _back,
      child: Scaffold(
        appBar:
            BaseAppBar(automaticallyImplyLeading: true, titleStr: widget.title)
                .webAppBar(
                    context,
                    PreferredSize(
                      child: _showLoading
                          ? Container(
                              height: 0.5,
                              child: LinearProgressIndicator(
                                backgroundColor: AppColor.color_4C64FC,
                              ),
                            )
                          : Container(),
                      preferredSize: Size(double.infinity, 0.5),
                    )),
        body: WebView(
          initialUrl: widget.url,

          ///初始化url
          javascriptMode: JavascriptMode.unrestricted,

          ///JS执行模式
          onWebViewCreated: (WebViewController webViewController) {
            ///在WebView创建完成后调用，只会被调用一次
//            _controller.complete(webViewController);
            _controller = webViewController;
          },
          javascriptChannels: <JavascriptChannel>[
            ///JS和Flutter通信的Channel；
//            _alertJavascriptChannel(context),
          ].toSet(),
          navigationDelegate: (NavigationRequest request) {
            //路由委托（可以通过在此处拦截url实现JS调用Flutter部分）；
            ///通过拦截url来实现js与flutter交互
            if (request.url.startsWith('js://webview')) {
//            Fluttertoast.showToast(msg: 'JS调用了Flutter By navigationDelegate');
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;

              ///阻止路由替换，不能跳转，因为这是js交互给我们发送的消息
            }

            return NavigationDecision.navigate;

            ///允许路由替换
          },
          onPageFinished: (String url) {
            ///页面加载完成回调
            setState(() {
              _showLoading = false;
            });
          },
        ),
      ),
    );
  }
}
