import 'package:flutter/material.dart';
import 'package:videotest/modules/ceshi/flutter_keyboard_visibility.dart';
import 'package:videotest/modules/download/page/download_page.dart';
import 'package:videotest/modules/keyboard/page/keyboard_avoider_page.dart';
import 'package:videotest/modules/keyboard/page/keyboard_page.dart';
import 'package:videotest/modules/keyboard/page/keyborad_ceshi_page.dart';
import 'package:videotest/modules/photo/photo_page.dart';
import 'package:videotest/modules/webview/page/html_page.dart';
import 'package:videotest/modules/webview/page/webview_html.dart';
import 'package:videotest/utils/adapter.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //    ///初始化ScreenUtil
    ScreenAdapter.setDesignWHs(context, 375, 667, allowFontScaling: true);
    var routeLists = routers.keys.toList();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(routeLists[index]);
                },
                child: Card(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: ScreenAdapter.getHeight(50),
                    child: Text(routers.keys.toList()[index]),
                  ),
                ),
              );
            },
            itemCount: routers.length,
          ),
        ));
  }
}

Map<String, WidgetBuilder> routers = {
  "跳转网页视频播放": (context) {
    return HtmlPage();
  },
  "下载": (context) {
    return DownFilePage();
  },
  "跳转网站": (context) {
    return WebViewHtmlPage();
  },
  "打开相册 image_picker": (context) {
    return PhotoPage();
  },
  "软键盘_keyboard_avoider插件": (context) {
    return KeyboardAvoiderPage();
  },
  "输入框遮挡": (context) {
    return KeyboardPage();
  },
  "输入框遮挡2": (context) {
    return TestPage();
  },
  "测试环境": (context) {
    return CeShi();
  },
  "网页视频播放": (context) {
    return WebViewHtmlPage();
  }
};
