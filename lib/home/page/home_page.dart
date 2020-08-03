import 'package:flutter/material.dart';
import 'package:videotest/modules/acquire/acquire_page.dart';
import 'package:videotest/modules/centered/centered_page.dart';
import 'package:videotest/modules/ceshi/flutter_keyboard_visibility.dart';
import 'package:videotest/modules/ceshi/tab.dart';
import 'package:videotest/modules/data_store/data_store_page.dart';
import 'package:videotest/modules/download/page/download_page.dart';
import 'package:videotest/modules/html_flutter_inappwebview/inapp_web_view.dart';
import 'package:videotest/modules/input_box/input_box.dart';
import 'package:videotest/modules/keyboard/page/keyboard_avoider_page.dart';
import 'package:videotest/modules/keyboard/page/keyboard_page.dart';
import 'package:videotest/modules/keyboard/page/keyborad_ceshi_page.dart';
import 'package:videotest/modules/list/list_sliding_to_monitor.dart';
import 'package:videotest/modules/photo/photo_page.dart';
import 'package:videotest/modules/pop_up/pop_up_windows.dart';
import 'package:videotest/modules/pull_down/pull_down_page.dart';
import 'package:videotest/modules/roll/filtrate_page.dart';
import 'package:videotest/modules/roll/roll_page.dart';
import 'package:videotest/modules/roll/roll_test.dart';
import 'package:videotest/modules/sqflite/packaging_spflite.dart';
import 'package:videotest/modules/sqflite/spflite_page.dart';
import 'package:videotest/modules/text/page/cross_dissolve_page.dart';
import 'package:videotest/modules/webview/page/ceshi_web.dart';
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
    return InappWebViewPage(
      url: 'https://v.youku.com/v_show/id_XNDcyNjQ4NDU5Ng==.html',
      title: '优酷',
    );
  },
  "文本输入框简单的": (context) {
    return InputBox();
  },
  "列表滑动监听": (context) {
    return ListSlidingToMonitor();
  },
  "文字 淡入淡出 动画": (context) {
    return CrossDissolvePage();
  },
  "循环滚动、且每次都停留在屏幕中间位置": (context) {
    return HousePerson(
      selectIndex: 2,
      clearData: false,
    );
  },
  "展示底部弹窗": (context) {
    return PopUpWindows();
  },
  "下拉菜单": (context) {
    return ChooseDownload();
  },
  "获取设备信息": (context) {
    return AcquirePage();
  },
  "数据存储之shared_preferences": (context) {
    return DataStorePage();
  },
  "web测试": (context) {
    return WebViewExample();
  },
  "数据库操作": (context) {
    return PackagingSpflite();
  },
  "封装数据库工具类": (context) {
    return SpflitePage();
  },
  "Tab切换": (context) {
    return TabDemo();
  },
  "卡片滚动": (context) {
    return Switchover();
  },
  "电影页面选择案例": (context) {
    return RollPage();
  },
  "滚动到列表指定item位置": (context) {
    return RollTest();
  }
};
